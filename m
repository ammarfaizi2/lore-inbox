Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266103AbTLaDyK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 22:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266104AbTLaDyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 22:54:10 -0500
Received: from ms-smtp-01-qfe0.nyroc.rr.com ([24.24.2.55]:6285 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S266103AbTLaDyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 22:54:08 -0500
From: craig duncan <duncan@nycap.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16370.18579.203219.50287@nycap.rr.com>
Date: Tue, 30 Dec 2003 22:54:59 -0500
To: Jens Axboe <axboe@suse.de>
Subject: Re: Problem with buffer underruns burning at 8x under 2.6
In-Reply-To: <20031230191712.GQ3086@suse.de>
References: <16365.58236.420224.645120@nycap.rr.com>
	<20031229192639.GI3086@suse.de>
	<16369.47055.613713.304233@nycap.rr.com>
	<20031230191712.GQ3086@suse.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes:
> Your problem is that DMA is disabled. I don't know why you say that
> hdparm doesn't work for you, how are you running it? I'm assuming that
> /dev/cdrom is linked to /dev/hdc (or where is you CDROM located?).

You're right... dma is disabled... for _all_ my drives.  Some change
between booting up in 2.4 vs 2.6.  I have no idea why... yet.

And hdparm does work fine on /dev/cdrom.  I did something stupid (ran
/sbin/hdparm as a normal user) which made me think it didn't.

Thanks for your help.

craig
