Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313122AbSEHO7t>; Wed, 8 May 2002 10:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314450AbSEHO7s>; Wed, 8 May 2002 10:59:48 -0400
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:6025 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S313122AbSEHO7s>; Wed, 8 May 2002 10:59:48 -0400
Date: Wed, 8 May 2002 09:59:47 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: ALi 15xx and Phoenix NoteBIOS suspend to disk problems?
Message-ID: <20020508095946.A886@ksu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-School: Kansas State University
X-vi-or-emacs: vi
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

I have a Toshiba Satellite 1605CDS (laptop).  It has a Phoenix BIOS, and
  an ALi 1541 chipset (aparently with M5229).  Relevant 2.5.14 boot info:
May  8 04:31:10 paulus agpgart: Maximum main memory to use for agp memory: 122M
May  8 04:31:10 paulus agpgart: Detected Ali M1541 chipset
May  8 04:31:10 paulus agpgart: AGP aperture is 64M @ 0xe0000000
May  8 04:31:10 paulus ATA/ATAPI driver v7.0.0
May  8 04:31:10 paulus ATA: system bus speed 33MHz
May  8 04:31:10 paulus ATA: interface: Acer Laboratories Inc. [ALi] M5229 IDE, on PCI slot 00:0f.0
May  8 04:31:10 paulus PCI: No IRQ known for interrupt pin A of device 00:0f.0.
May  8 04:31:10 paulus ATA: chipset rev.: 32
May  8 04:31:10 paulus ATA: non-legacy mode: IRQ probe delayed
May  8 04:31:10 paulus ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:DMA, hdb:pio
May  8 04:31:10 paulus ide1: BM-DMA at 0xfcf8-0xfcff, BIOS settings: hdc:DMA, hdd:pio

Anyhow, ever since I've seen the ALi 15xx chipset option (in the kernel
  IDE chipset-specific config section), that is, since possibly before
  kernel version 2.4.0, whenever I've enabled the ALi chipset support and
  then suspend the laptop, the BIOS halts partway through the suspend-to-disk
  screen (the "Sytem Information" and "Conventional Memory" sections complete
  the save-to-disk operation, but the "Extended Memory" bar never gets past
  zero progress; this is all in the "Phoenix NoteBIOS 4.0 Save To Disk Manager"
  screen, which starts a few screen flickers after calling apm -s.  BIOS is
  set to suspend to disk instead of suspending to RAM).
Any ideas what might be causing these problems?  Thanks!

-Joseph
-- 
Joseph======================================================jap3003@ksu.edu
[While discussing 8 new IIS (Microsoft's webserver) vulnerabilities]
"One workaround we rather like is called Apache, but we digress...."
  Greene, The Register, http://www.theregister.co.uk./content/4/24795.html
