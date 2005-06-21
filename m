Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVFUJmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVFUJmg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 05:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVFUJmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 05:42:10 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:2979 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262096AbVFUJlS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 05:41:18 -0400
Subject: Re: PATCH: Samsung SN-124 works perfectly well with DMA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <42B72EDC.6040707@pobox.com>
References: <1119298324.3304.29.camel@localhost.localdomain>
	 <42B72EDC.6040707@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119346591.3707.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Jun 2005 10:36:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-06-20 at 22:02, Jeff Garzik wrote:
> Alan Cox wrote:
> > Been in Red Hat products for ages
> > 
> > Signed-off-by: Alan Cox <alan@redhat.com>
> 
> Can you provide a similar patch for ata_dma_blacklist[] in libata-core.c?

Good point. 

--- drivers/scsi/libata-core.c~	2005-06-21 10:34:00.503444736 +0100
+++ drivers/scsi/libata-core.c	2005-06-21 10:34:00.504444584 +0100
@@ -1897,7 +1897,6 @@
 	"SAMSUNG CD-ROM SC-148C",
 	"SAMSUNG CD-ROM SC",
 	"SanDisk SDP3B-64",
-	"SAMSUNG CD-ROM SN-124",
 	"ATAPI CD-ROM DRIVE 40X MAXIMUM",
 	"_NEC DV5800A",
 };


Signed-off-by: Alan Cox <alan@redhat.com>

