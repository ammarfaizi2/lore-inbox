Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293151AbSB1WDm>; Thu, 28 Feb 2002 17:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310147AbSB1WCN>; Thu, 28 Feb 2002 17:02:13 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:57349 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S310141AbSB1V6r> convert rfc822-to-8bit; Thu, 28 Feb 2002 16:58:47 -0500
Date: Thu, 28 Feb 2002 17:50:07 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ralf Baechle <ralf@oss.sgi.com>,
        David Mosberger <davidm@napali.hpl.hp.com>
Subject: Linux 2.4.19-pre2
Message-ID: <Pine.LNX.4.21.0202281742250.2182-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here is 2.4.19-pre2: A very big patch (around 13MB uncompressed) due to
the architecture (MIPS and IA64 mainly) updates. 

Ralf and David: Please check if the merges have been done correctly (eg
no new files missing).

pre2:

- -ac merge						(Alan Cox)
- Huge MIPS/MIPS64 merge				(Ralf Baechle)
- IA64 update						(David Mosberger)
- PPC update						(Tom Rini)
- Shrink struct page					(Rik van Riel)
- QNX4 update (now its able to mount QNX 6.1 fses)	(Anders Larsen)
- Make max_map_count sysctl configurable		(Christoph Hellwig)
- matroxfb update					(Petr Vandrovec)
- ymfpci update						(Pete Zaitcev)
- LVM update						(Heinz J. Mauelshagen)
- btaudio driver update					(Gerd Knorr)
- bttv update						(Gerd Knorr)
- Out of line code cleanup				(Keith Owens)
- Add watchdog API documentation			(Christer Weinigel)
- Rivafb update						(Ani Joshi)
- Enable PCI buses above quad0 on NUMA-Q		(Martin J. Bligh)
- Fix PIIX IDE slave PCI timings			(Dave Bogdanoff)
- Make PLIP work again					(Tim Waugh)
- Remove unecessary printk from lp.c			(Tim Waugh)
- Make parport_daisy_select work for ECP/EPP modes	(Max Vorobiev)
- Support O_NONBLOCK on lp/ppdev correctly		(Tim Waugh)
- Add PCI card hooks to parport				(Tim Waugh)
- Compaq cciss driver fixes				(Stephen Cameron)
- VFS cleanups and fixes				(Alexander Viro)
- USB update (including USB 2.0 support)		(Greg KH)
- More jiffies compare cleanups				(Tim Schmielau)
- PCI hotplug update					(Greg KH)
- bluesmoke fixes					(Dave Jones)
- Fix off-by-one in ide-scsi				(John Fremlin)
- Fix warnings in make xconfig				(René Scharfe)
- Make x86 MCE a configure option			(Paul Gortmaker)
- Small ramdisk fixes					(Christoph Hellwig)
- Add missing atime update to pipe code			(Christoph Hellwig)
- Serialize microcode access				(Tigran Aivazian)
- AMD Elan handling on serial.c				(Robert Schwebel)


pre1:

- Add tape support to cciss driver			(Stephen Cameron)
- Add Permedia3 fb driver				(Romain Dolbeau)
- meye driver update					(Stelian Pop)
- opl3sa2 update					(Zwane Mwaikambo)
- JFFS2 update						(David Woodhouse)
- NBD deadlock fix					(Steven Whitehouse)
- Correct sys_shmdt() return value on failure		(Adam Bottchen)
- Apply the SET_PERSONALITY patch missing from 2.4.18 	(me)
- Alpha update						(Jay Estabrook)
- SPARC64 update					(David S. Miller)
- Fix potential blk freelist corruption			(Jens Axboe)
- Fix potential hpfs oops				(Chris Mason)
- get_request() starvation fix				(Andrew Morton)
- cramfs update						(Daniel Quinlan)
- Allow binfmt_elf as module				(Paul Gortmaker)
- ymfpci Configure.help update				(Pete Zaitcev)
- Backout one eepro100 change made in 2.4.18: it 
  was causing slowdowns on some cards			(Jeff Garzik)
- Tridentfb compilation fix				(Jani Monoses)
- Fix refcounting of directories on renames in tmpfs	(Christoph Rohland)
- Add Fujitsu notebook to broken APM implementation 
  blacklist						(Arjan Van de Ven)
- "do { ... } while(0)" cleanups on some fb drivers	(Geert Uytterhoeven)
- Fix natsemi's ETHTOOL_GLINK ioctl			(Tim Hockin)
- Fix clik! drive detection code in ide-floppy		(Paul Bristow)
- Add additional support for the 82801 I/O controller	(Wim Van Sebroeck)
- Remove duplicates in pci_ids.h			(Wim Van Sebroeck)





