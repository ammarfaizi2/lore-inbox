Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbVKACJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVKACJb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 21:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVKACJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 21:09:31 -0500
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:35820 "EHLO
	imf18aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S932511AbVKACJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 21:09:31 -0500
Subject: Re: patch to add a config option to enable SATA ATAPI by default
From: Mark Tomich <tomichm@bellsouth.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <4365FF53.8000707@pobox.com>
References: <1130691328.8303.8.camel@localhost>
	 <20051031102723.GA10037@suse.de>  <4365FF53.8000707@pobox.com>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 21:09:23 -0500
Message-Id: <1130810963.21921.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe I'm just not doing it properly, but I wasn't able to specify the
"atapi_enabled" option on the kernel command line.  I tried it, but it
still didn't see my  CD-ROM drive.  That's why I wrote the patch.
Anyway, thanks for all your work on LIBATA.

On Mon, 2005-10-31 at 06:26 -0500, Jeff Garzik wrote:
> Olaf Hering wrote:
> >  On Sun, Oct 30, Mark Tomich wrote:
> > 
> > 
> >>Below is a very straight-forward patch to add a config option to
> >>enabling SATA ATAPI by default.
> > 
> > 
> >>diff -u -r linux-2.6.14-rc5/drivers/scsi/Kconfig
> >>linux-2.6.14-rc5-patched/drivers/scsi/Kconfig
> >>--- linux-2.6.14-rc5/drivers/scsi/Kconfig	2005-10-30 11:09:15.533533419 -0500
> >>+++ linux-2.6.14-rc5-patched/drivers/scsi/Kconfig	2005-10-30 11:21:39.735696058 -0500
> >>@@ -445,6 +445,17 @@
> >> 
> >> 	  If unsure, say N.
> >> 
> >>+config SCSI_SATA_ENABLE_ATAPI
> >>+	bool "Enable SATA ATAPI by default"
> > 
> > 
> > Jeff, will you apply this?
> 
> Nope.  It's already a runtime option.  The runtime option will default 
> to enabled when ATAPI is working 100%.
> 
> 	Jeff
> 
> 
> 

