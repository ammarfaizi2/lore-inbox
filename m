Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268156AbRGZQAF>; Thu, 26 Jul 2001 12:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268145AbRGZP7z>; Thu, 26 Jul 2001 11:59:55 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:47112 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268156AbRGZP7v>; Thu, 26 Jul 2001 11:59:51 -0400
Date: Thu, 26 Jul 2001 11:29:50 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alan Cox <laughing@shared-source.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.7-ac1
In-Reply-To: <20010726142101.A14439@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0107261128340.3955-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Thu, 26 Jul 2001, Alan Cox wrote:

> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> 
> 		 Intermediate diffs are available from
> 			http://www.bzimage.org
> 
> 2.4.7-ac1

-D__KERNEL__ -I/home/marcelo/rpm/BUILD/kernel-2.4.7/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe  -march=i386 -DMODULE -DMODVERSIONS
-include
/home/marcelo/rpm/BUILD/kernel-2.4.7/linux/include/linux/modversions.h -c
-o scsi.o scsi.c
scsi.c: In function `scsi_reset_provider_Rsmp_b879693c':
scsi.c:2729: structure has no member named `sem'
make[2]: *** [scsi.o] Error 1
make[2]: Leaving directory
`/home/marcelo/rpm/BUILD/kernel-2.4.7/linux/drivers/scsi'


