Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVBNOSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVBNOSz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 09:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVBNOSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 09:18:55 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:53888 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261435AbVBNOSx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 09:18:53 -0500
Date: Mon, 14 Feb 2005 15:18:53 +0100
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: repost: 2.6.11-rc4 BUG: using smp_processor_id() in preemptible [00000001] code: ip/6840
Message-ID: <20050214141853.GA8245@janus>
References: <20050206195111.GA28814@janus> <20050213193037.GA2802@janus> <4210AFC5.2030807@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4210AFC5.2030807@tiscali.de>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 03:03:49PM +0100, Matthias-Christian Ott wrote:
> >On Sun, Feb 06, 2005 at 08:51:11PM +0100, Frank van Maarseveen wrote:
> > 
[...]

> >still present in -rc4:
> >kernel: BUG: using smp_processor_id() in preemptible [00000001] code: 
> >ip/6351
> >kernel: caller is get_next_corpse+0x13/0x260
> >kernel:  [<c010385e>] dump_stack+0x1e/0x30
[...]

> >
> Than fix it, the way I mentioned.

Yes, I can do that and thanks for the info.

I'm only reporting it because I think that it may be relevant for others:
Someone may want to fix it before 2.6.11 final comes out. I think it is
easier for the maintainer and most other people on the list to notice
it and fix it than it is for me to get a fix through the proper channels.

Don't worry, I won't report it a third time..

-- 
Frank
