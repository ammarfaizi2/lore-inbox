Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281067AbRK3W26>; Fri, 30 Nov 2001 17:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281077AbRK3W2s>; Fri, 30 Nov 2001 17:28:48 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:27411 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281067AbRK3W2l>; Fri, 30 Nov 2001 17:28:41 -0500
Date: Fri, 30 Nov 2001 19:11:37 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Linux 2.4.17-pre2
Message-ID: <Pine.LNX.4.21.0111301901320.17660-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ok, here it goes.

Lots of driver changes this time... 

Also, I want to know if people feel any difference on interactivity under
heavy IO workloads.

pre2:

- Remove userland header from bonding driver	(David S. Miller)
- Create a SLAB for page tables on i386		(Christoph Hellwig)
- Unregister devices at shaper unload time	(David S. Miller)
- Remove several unused variables from various
  places in the kernel				(David S. Miller)
- Fix slab code to not blindly trust cc_data():
  it may be not valid on some platforms		(David S. Miller)
- Fix RTC driver bug				(David S. Miller)
- SPARC 32/64 update				(David S. Miller)
- W9966 V4L driver update			(Jakob Jemi)
- ad1848 driver fixes				(Alan Cox/Daniel T. Cobra)
- PCMCIA update					(David Hinds)
- Fix PCMCIA problem with multiple PCI busses 	(Paul Mackerras)
- Correctly free per-process signal struct	(Dave McCracken)
- IA64 PAL/signal headers cleanup		(Nathan Myers)
- ymfpci driver cleanup 			(Pete Zaitcev)
- Change NLS "licenses" to be "GPL/BSD" instead 
  only BSD.					(Robert Love)
- Fix serial module use count			(Russell King)
- Update sg to 3.1.22				(Douglas Gilbert)
- ieee1394 update				(Ben Collins)
- ReiserFS fixes				(Nikita Danilov)
- Update ACPI documentantion			(Patrick Mochel)
- Smarter atime update				(Andrew Morton)
- Correctly mark ext2 sb as dirty and sync it	(Andrew Morton) 
- IrDA update					(Jean Tourrilhes)
- Count locked buffers at
  balance_dirty_state(): Helps interactivity under
  heavy IO workloads				(Andrew Morton)
- USB update					(Greg KH)
- ide-scsi locking fix				(Christoph Hellwig)

pre1:

- Change USB maintainer 			(Greg Kroah-Hartman)
- Speeling fix for rd.c				(From Ralf Baechle's tree)
- Updated URL for bigphysmem patch in v4l docs  (Adrian Bunk)
- Add buggy 440GX to broken pirq blacklist 	(Arjan Van de Ven)
- Add new entry to Sound blaster ISAPNP list	(Arjan Van de Ven)
- Remove crap character from Configure.help	(Niels Kristian Bech Jensen)
- Backout erroneous change to lookup_exec_domain (Christoph Hellwig)
- Update osst sound driver to 1.65		(Willem Riede)
- Fix i810 sound driver problems		(Andris Pavenis)
- Add AF_LLC define in network headers		(Arnaldo Carvalho de Melo)
- block_size cleanup on some SCSI drivers	(Erik Andersen)
- Added missing MODULE_LICENSE("GPL") in some   (Andreas Krennmair)
  modules
- Add ->show_options() to super_ops and 
  implement NFS method				(Alexander Viro)
- Updated i8k driver				(Massimo Dal Zoto)
- devfs update  				(Richard Gooch)


