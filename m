Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284927AbRLUSAs>; Fri, 21 Dec 2001 13:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284929AbRLUSAg>; Fri, 21 Dec 2001 13:00:36 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:2052 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284927AbRLUSA0>; Fri, 21 Dec 2001 13:00:26 -0500
Date: Fri, 21 Dec 2001 14:45:52 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Linux 2.4.17
Message-ID: <Pine.LNX.4.21.0112211439390.7313-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, 

Here it is... 


final:

- Fix more loopback deadlocks			(Andrea Arcangeli)
- Make Alpha with Nautilus chipset and
  Irongate chipset configuration compile
  correctly					(Michal Jaegermann)

rc2: 

- Fix potential oops with via-rhine		(Andrew Morton)
- sysvfs: mark inodes as bad in case of read 
  failure					(Christoph Hellwig)
- NTFS bugfixes					(Anton Altaparmakov)
- Fix Netfilter oops				(Edward Killips)
- Direct IO error handling fix			(Masaroni Goto)
- Fix loop device deadlock			(Andrea Arcangeli)
- Make some erroneously global spinlocks 
  static					(David C. Hansen)
- Avoid i810 driver from oopsing with 830ME	(Robert Love)
- Reiserfs fixes				(Oleg Drokin/Chris Mason)
- Fix VM "not-swapping" issue with lowmem 
  machines					(Rik van Riel)
- Make kernel try a bit harder to shrink caches
  instead swapping out	 			(me)
- Make NCR5380 compile builtin			(Erik Andersen)
- More __devexit_p fixes			(Daniel T. Chen)
- devfs bugfixes				(Richard Gooch)


rc1: 

- Finish MODULE_LICENSE fixups for fs/nls 	(Mark Hymers)
- Console race fix				(Andrew Morton/Robert Love)
- Configure.help update				(Eric S. Raymond)
- Correctly fix Direct IO bug			(Linus Benedict Torvalds)
- Turn off aacraid debugging			(Alan Cox)
- Added missing spinlocking in do_loopback()	(Alexander Viro)
- Added missing __devexit_p() in i82092 
  pcmcia driver					(Keith Owens)
- ns83820 zerocopy bugfix			(Benjamin LaHaise)
- Fix VM problems where cache/buffers didn't get
  freed						(me)

pre8:

- ext3 quota fix 				(Neil Brown)
- Add __devexit_p() to ISDN driver		(Kai Germaschewski)
- Declare missing function on fdomain.h		(Eyal Lebedinsky)
- Add Sony Vaio PCG-Z600NE to broken APM 
  reporting blacklist				(Kai Germaschewski)
- ns83820 driver update				(Benjamin LaHaise)
- pas16 driver cleanup				(Alan Cox)
- disable console flush on secondary CPUs on
  IA64						(Andrew Morton)
- fix typo on parport's ChangeLog		(Tim Waugh)
- fix use count for multiple queued requests on 
  closed fd					(Douglas Gilbert)
- Check return value of get_user() on 
  set_vesa_blanking				(Jeff Garzik)
- Remove asm/segment.h include from nbd 	(Jeff Garzik)
- Guard sysrq.h against multiple inclusion 	(Jeff Garzik)
- Minor PCI skeleton changes			(Jeff Garzik)
- Add via rhine MMIO to Configure.help		(Jeff Garzik)
- Jeff Garzik is not the via82cxxx driver 
  maintainer anymore: "No time, no hardware".	(Jeff Garzik)
- Remove old tulip documentation		(Jeff Garzik)
- Avoid direct IO's "misunderstanding" of which 
  block device it should use			(Masanori Goto)
- Remove mcheck_init() call from processor
  dependant code and put it in unified codepath	(Dave Jones)
- Netfilter bugfixes				(Harald Welte)


pre7:

- More USB updates				(Greg KH)
- Add missing checks on shmat()			(Christoph Rohland)
- ymfpci update					(Pete Zaitcev)
- Add aacraid driver 				(Alan Cox)
- Actually apply some of the Alan's changes
  which were on pre6 changelog.			(silly me)
- Clean up t128 SCSI driver			(Alan Cox)
- Clean up dtc SCSI driver			(Alan Cox) 
- Undo lcall patch from -pre6			(me)
- More ISDN updates				(Kai Germaschewski)

pre6:

- ISDN fixes					(Kai Germaschewski)
- Eicon driver updates				(Kai Germaschewski)
- ymfpci update					(Pete Zaitcev)
- Fix multithread coredump deadlock		(Manfred Spraul)
- Support /dev/kmem access to vmalloc space	(Marc Boucher)
- ext3 fixes/enhancements			(Andrew Morton)	
- Add IT8172G driver to Config.in/Makefile	(Giacomo Catenazzi)
- Configure.help update				(Eric S. Raymond)
- Create __devexit_p() function and use that on 
  drivers which need it to make it possible to 
  use newer binutils				(Keith Owens) 
- Make PCMCIA compile without PCI support	(Paul Mackerras)
- Use copy_user_highpage instead copy_highpage
  on COW path.					(David S. Miller)
- Cacheline align some more performance
  critical spinlocks				(Anton Blanchard)
- sonypi driver update				(Michael C.B. Ashley/Bob Donnelly)
- direct render for some SiS cards		(Torsten Duwe/Alan Cox)
- full handling of the NFSv3 'jukebox' feature  (Trond Myklebust)
- NFS performance improvements			(Trond Myklebust)
- More parport fixes				(Tim Waugh)
- Fix lots of core NCR5380 bugs			(Alan Cox)
- NCR5380/PAS driver update			(Alan Cox)
- Add aacraid to the SCSI list			(Alan Cox)
- fdomain driver fixes				(Alan Cox)

pre5:

- 8139too fixes					(Andreas Dilger)
- sym53c8xx_2 update				(Gerard Roudier)
- loopback deadlock bugfix			(Jan Kara)
- Yet another devfs update			(Richard Gooch)	
- Enable K7 SSE					(John Clemens)
- Make grab_cache_page return NULL instead 
  ERR_PTR: callers expect NULL on failure	(Christoph Hellwig)
- Make ide-{disk-floppy} compile without 
  PROCFS support				(Robert Love)
- Another ymfpci update				(Pete Zaitcev)
- indent NCR5380.{c,h}, g_NCR5380.{c,h}, plus 
  NCR5380 fix					(Alan Cox)
- SPARC32/64 update				(David S. Miller)
- Fix atyfb warnings				(David S. Miller)
- Make bootmem init code correctly align 
  bootmem data					(David S. Miller)
- Networking updates				(David S. Miller)
- Fix scanning luns > 7 on SCSI-3 devices 	(Michael Clark)
- Add sparse lun hint for Chaparral G8324 
	Fibre-SCSI controller			(Michael Clark)
- Really apply sg changes			(me)
- Parport updates				(Tim Waugh)
- ReiserFS updates				(Vladimir V. Saveliev)
- Make AGP code scan all kinds of devices:
  they are not always video ones		(Alan Cox)
- EXPORT_NO_SYMBOLS in floppy.c			(Alan Cox)
- Pentium IV Hyperthreading support		(Alan Cox)

pre4:

- Added missing tcp_diag.c and tcp_diag.h	(me)

pre3:

- Enable ppro errata workaround                 (Dave Jones)
- Update tmpfs documentation                    (Christoph Rohland)
- Fritz!PCIv2 ISDN card support                 (Kai Germaschewski)
- Really apply ymfpci changes                   (Pete Zaitcev)
- USB update                                    (Greg KH)
- Adds detection of more eepro100 cards         (Troy A. Griffitts)
- Make ftruncate64() compliant with SuS         (Andrew Morton)
- ATI64 fb driver update                        (Geert Uytterhoeven)
- Coda fixes                                    (Jan Harkes)
- devfs update                                  (Richard Gooch)
- Fix ad1848 breakage in -pre2                  (Alan Cox)
- Network updates                               (David S. Miller)
- Add cramfs locking                            (Christoph Hellwig)
- Move locking of page_table_lock on expand_stack
  before accessing any vma field                (Manfred Spraul)
- Make time monotonous with gettimeofday        (Andi Kleen)
- Add MODULE_LICENSE(GPL) to ide-tape.c         (Mikael Pettersson)
- Minor cs46xx ioctl fix                        (Thomas Woller)

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
- ide-scsi locking fix                          (Christoph Hellwig)

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


