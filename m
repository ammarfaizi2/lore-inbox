Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269252AbUINKB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269252AbUINKB4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 06:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269255AbUINKB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 06:01:56 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:60339 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S269252AbUINKAL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 06:00:11 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 14 Sep 2004 11:49:28 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Peter Osterlund <petero2@telia.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc2
Message-ID: <20040914094928.GF27258@bytesex>
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org> <m3ekl5de7b.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3ekl5de7b.fsf@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 11:57:44PM +0200, Peter Osterlund wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Gerd Knorr:
> >   o v4l: bttv driver update
> 
> This patch,
> 
> Output from dmesg with a working kernel: (-rc2 with the above patch reverted)

> [ ... ]

> When running the crashing kernel, the last line in /var/log/messages
> after the crash is:
> 
>     bttv0: pinnacle/mt: id=2 info="PAL+SECAM / stereo" radio=yes
> 
> Maybe there is more data that doesn't make it to the disk. I can try
> again with a serial console if you think that would help.

That certainly is incomplete, at least the insmod messages should be
there if mencoder triggeres the crash.  A serial console log would be
helpful.  You can also try to reverse only parts of the patch, only the
changes in bttv-driver.c and/or in bttv-risc.c and see what happens.

Which format+size you are capturing with mencoder?

  Gerd

-- 
return -ENOSIG;
