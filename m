Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267152AbSKMJ7b>; Wed, 13 Nov 2002 04:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267156AbSKMJ7b>; Wed, 13 Nov 2002 04:59:31 -0500
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:50078 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S267152AbSKMJ71>; Wed, 13 Nov 2002 04:59:27 -0500
Date: Wed, 13 Nov 2002 10:06:15 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
X-X-Sender: mb@jester.mews
To: Margit Schubert-While <margit@margit.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.47-ac2
In-Reply-To: <4.3.2.7.2.20021113091351.00b51c90@mail.dns-host.com>
Message-ID: <Pine.LNX.4.44.0211131003330.3300-100000@jester.mews>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Auth-User: mb
X-uvscan-result: clean (18BuPX-0003zG-00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:43 +0100 Margit Schubert-While wrote:

>To keep you all busy :-)
>
>In file included from drivers/block/DAC960.c:49:
>drivers/block/DAC960.h:2572:2: #error I am a non-portable driver, please 
>convert me to use the Documentation/DMA-mapping.txt interfaces

For the keen:

$ find drivers/ -name "*.[ch]" \
	-exec grep -l 'Documentation/DMA-mapping.txt' "{}" \;

drivers/net/defxx.c
drivers/net/rrunner.c
drivers/net/rcpci45.c
drivers/scsi/scsiiom.c
drivers/scsi/53c7,8xx.c
drivers/scsi/dpt_i2o.c
drivers/scsi/gdth.c
drivers/scsi/eata_dma.c
drivers/scsi/AM53C974.c
drivers/scsi/ini9100u.c
drivers/block/DAC960.h
drivers/media/video/video-buf.h
drivers/message/i2o/i2o_lan.c
drivers/parisc/sba_iommu.c

