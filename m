Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269273AbUINLUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269273AbUINLUn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269075AbUINLPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:15:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58033 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269273AbUINLNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:13:40 -0400
Date: Tue, 14 Sep 2004 13:12:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
Message-ID: <20040914111207.GR2336@suse.de>
References: <20040914060628.GC2336@suse.de> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAA6P8AlyGHikORXOqFZ6fdPAEAAAAA@syphir.sytes.net> <20040914070649.GI2336@suse.de> <20040914071555.GJ2336@suse.de> <1095156542.16570.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095156542.16570.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14 2004, Alan Cox wrote:
> On Maw, 2004-09-14 at 08:15, Jens Axboe wrote:
> > 	printf("issuing FLUSH_CACHE: ");
> > 	if (ioctl(fd, HDIO_DRIVE_TASK, args) == -1)
> > 		printf("failed 0x%x/0x%x!\n", args[0], args[1]);
> > 	else
> > 		printf("worked\n");
> 
> Drive acked the command is all that proves. Maybe its a nop, maybe it
> does it, maybe like the last time someone engaged in this kind of "lets
> not check" approach it erases your firmware and leaves your CD-ROM drive
> defunct as the Mandrake error of the same form did.

Alan, you are sounding like a broken record :)

-- 
Jens Axboe

