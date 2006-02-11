Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWBKLsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWBKLsU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 06:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWBKLsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 06:48:20 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:48658 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S1751084AbWBKLsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 06:48:20 -0500
Date: Sat, 11 Feb 2006 12:48:18 +0100
From: iSteve <isteve@rulez.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Packet writing issue on 2.6.15.1
Message-ID: <20060211124818.063074cc@silver>
In-Reply-To: <m3r76a875w.fsf@telia.com>
References: <20060211103520.455746f6@silver>
	<m3r76a875w.fsf@telia.com>
X-Mailer: Sylpheed-Claws 2.0.0cvs42 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Feb 2006 12:30:03 +0100
Peter Osterlund <petero2@telia.com> wrote:
> Unfortunately the driver doesn't support variable packet sizes. You
> have to format the disc with a fixed packet size.
> 
> Incidentally, the latest git tree (2.6.16-rc2-git10) already contains
> a change which would have made the mount command fail in this case.
> 
I apologize for lack of insight in this matter, but... Where is the packet
fixed/variable size set? In the UDF filesystem? Or somewhere in metadata of the
CD? Can I alter it with some data already on the CD, without losing the data?

If the driver cannot handle variable packet size, and it is not matter of
filesystem but matter of CDRW (which I presume), shouldn't the whole pktsetup
fail?

Thanks in advance
-- 
 -- iSteve
