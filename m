Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUIOCrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUIOCrg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 22:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266903AbUIOCrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 22:47:36 -0400
Received: from [69.28.190.101] ([69.28.190.101]:52354 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266891AbUIOCrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 22:47:31 -0400
Date: Tue, 14 Sep 2004 22:47:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Mark Lord <lsml@rtr.ca>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Mark Lord <lkml@rtr.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] New QStor SATA/RAID Driver for 2.6.9-rc2
Message-ID: <20040915024720.GA23694@havoc.gtf.org>
References: <41471163.10709@rtr.ca> <414723B0.1090600@pobox.com> <1095186343.2008.29.camel@mulgrave> <4147AB5A.4060804@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4147AB5A.4060804@rtr.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Groovy.  FWIW (if it wasn't obvious from context) my objection in
general to the driver is withdrawn, since you explained it is RAID and
not an ATA driver.

I would really like to work on consolidating the ATA code in libata,
though.  As the name implies, it's a library -- don't feel that your
driver must conform to the libata driver API in order to make use of all
its functions.  And feel free to add to it.

	Jeff



