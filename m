Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292728AbSBUTQe>; Thu, 21 Feb 2002 14:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292729AbSBUTQL>; Thu, 21 Feb 2002 14:16:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61192 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292728AbSBUTQF>; Thu, 21 Feb 2002 14:16:05 -0500
Subject: Re: AIC7XXX 6.2.5 driver
To: gibbs@scsiguy.com (Justin T. Gibbs)
Date: Thu, 21 Feb 2002 19:30:19 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), axboe@suse.de (Jens Axboe),
        scarfoglio@arpacoop.it (Carlo Scarfoglio),
        linux-kernel@vger.kernel.org
In-Reply-To: <200202211909.g1LJ9mI48542@aslan.scsiguy.com> from "Justin T. Gibbs" at Feb 21, 2002 12:09:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dyv5-0007xz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> included in certain 2.4.18-pre kernels which was the cause of the patch
> not working for him.  I can only assume you ran into the same problem.
> My patch was relative to 2.4.17, not a more recent, yet unblessed, kernel.

Relative to 2.4.18-rc would be good

> As to the CMD640 patch.  Can you let me know why you believe it breaks
> the CMD640?  The current scheme leaks transactions on the bus and *will*

The CMD640 can't do 32bit config space access stuff - thats why the code
is there to hack around it. That code needs to know or check what pci
config mode it should have used.

> Information about the SCSI mid-layer changes were posted to the SCSI list
> and I believe CC'd to you.  If you need that information again, I'd be
> happy to resend it.

The midlayer stuff Im more than happy with
