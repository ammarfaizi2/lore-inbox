Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289287AbSAVSbu>; Tue, 22 Jan 2002 13:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289336AbSAVSbl>; Tue, 22 Jan 2002 13:31:41 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:37382 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S289287AbSAVSb2>; Tue, 22 Jan 2002 13:31:28 -0500
Date: Tue, 22 Jan 2002 15:20:24 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.18-pre5
Message-ID: <Pine.LNX.4.21.0201221514140.2056-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I was waiting for the icmp overflow problem to be fixed to release this
kernel, but it only exists only on 2.2.

Well, here goes pre5.


pre5:

- Include missing radeonfb defines		(Erik Andersen)
- Fix fs/buffer.c thinko introduced in pre4	(Andrew Morton)
- USB bugfixes					(Greg KH)
- Make fat work correctly with gcc-3.0.x 	(Tom Rini)
- Avoid overusage of the vmalloc area by 
  NTFS						(Anton Altaparmakov)
- atyfb: Decrease clock rate for 3d RAGE XL 	(David S. Miller)
- Sungem driver bugfixes			(David S. Miller)
- More networking updates			(David S. Miller)
- More SPARC updates				(David S. Miller)
- devfs update 					(Richard Gooch)
- Reiserfs expanding truncate fix		(Chris Mason)
- ext3 update					(Andrew Morton/Stephen Tweedie)
- Add support to WDIOC_SETTIMEOUT on several
  watchdog drivers				(Joel Becker)
- dl2k driver update				(Jeff Garzik)
- Orinoco driver update				(David Gibson)
- Radeonfb driver update			(Ani Joshi)
- Avoid free_swap_and_cache() from leaving 
  freeable pages on the cache			(Hugh Dickins)
- Add workarounds for AMD Elan processors	(Robert Schwebel)
- Random pmac driver bugfixing			(Benjamin Herrenschmidt)
- emu10k1 driver update				(Rui Sousa)

pre4:

- Networking updates				(David S. Miller)
- clgenfb update				(Jeff Garzik)
- 8139cp: make it faster			(Jeff Garzik)
- 8139too: fix bugs, add experimental RX reset	(Jeff Garzik)
- Add MII ethtool interface and change 
  several drivers to support that		(Jeff Garzik)
- Fix ramdisk corruption problems		(Andrea Arcangeli) 	
- Correct in-kernel MS_ASYNC behaviour 
  on msync/fsync()				(Andrew Morton)
- Fix PLIP problems 				(Niels Jensen)
- Fix problems triggered by the "fsx test" 
  on smbfs					(Urban Widmark)
- Turn on OOSTORE for IDT winchip		(from -ac tree)
- Fix iphase crash				(from -ac tree)
- Fix crash with two mxser cards		(from -ac tree)
- Fix tty write block bug			(from -ac tree)
- Add mono/stereo detect to gemtek pci radio	(from -ac tree)
- Fix sf16fmi crash on load			(from -ac tree)
- add CP1250 (windows eastern european) 
  translation table				(from -ac tree)
- cs46xx driver update				(from -ac tree)
- Fix rare data loss case with RAID-1		(Ingo Molnar)
- Add 2.5.x compatibility for the kdev_t
  changes					(me)
- SPARC updates					(David S. Miller)

pre3:

- Cris arch merge				(Bjorn Wesen)
- Finish PPC merge				(Benjamin Herrenschmidt)
- Add Dell PowerEdge 2400 to 
  "use BIOS to reboot" blacklist		(Arjan van de Ven)
- Avoid potential oops at module unload with 
  cyclades driver				(Andrew Morton)
- Gracefully handle SCSI initialization 
  failures					(Pete Zaitcev)
- USB update					(Greg KH)
- Fix potential oops while ejecting ide cds 	(Zwane Mwaikambo)
- Unify page freeing codepaths 			(Benjamin LaHaise)
- Miata dma corruption workaround 		(Richard Henderson)
- Fix vmalloc corruption problem on machines 
  with virtual dcaches				(Ralf Baechle)
- Reiserfs fixes				(Oleg Drokin)
- DiskOnChip driver update			(David Woodhouse)
- Do not inherit page locking rules across 
  fork/exec					(Dave Anderson)
- Add DRM 4.0 for XFree 4.0 users convenience	(Christoph Hellwig)
- Replace .text.lock with .subsection 		(Keith Owens)
- IrDA bugfixes					(Jean Tourrilhes)

pre2: 

- APIC LVTERR fixes				(Mikael Pettersson)
- Fix ppdev ioctl oops and deadlock		(Tim Waugh)
- parport fixes					(Tim Waugh)
- orinoco wireless driver update		(David Gibson)
- Fix oopsable race in binfmt_elf.c 		(Alexander Viro)
- Small sx16 driver bugfix			(Heinz-Ado Arnolds)
- sbp2 deadlock fix 				(Andrew Morton)
- Fix JFFS2 write error handling		(David Woodhouse)
- Intermezzo update				(Peter J. Braam)
- Proper AGP support for Intel 830MP chipsets	(Nicolas Aspert)
- Alpha fixes					(Jay Estabrook)
- 53c700 SCSI driver update			(James Bottomley)
- Fix coredump mmap_sem deadlock on IA64	(David Mosberger)
- 3ware driver update				(Adam Radford)
- Fix elevator insertion point on failed 
  request merge					(Jens Axboe)
- Remove bogus rpciod_tcp_dispatcher definition (David Woodhouse)
- Reiserfs fixes				(Oleg Drokin)
- de4x5 endianess fixes				(Kip Walker)
- ISDN CAPI cleanup				(Kai Germaschewski)
- Make refill_inactive() correctly account 
  progress					(me)

pre1:

- S390 merge					(IBM)
- SuperH merge					(SuperH team)
- PPC merge					(Benjamin Herrenschmidt)
- PCI DMA update				(David S. Miller)
- radeonfb update 				(Ani Joshi)
- aty128fb update				(Ani Joshi)
- Add nVidia GeForce3 support to rivafb		(Ani Joshi)
- Add PM support to opl3sa2			(Zwane Mwaikambo)
- Basic ethtool support for 3com, starfire
  and pcmcia net drivers			(Jeff Garzik)
- Add MII ethtool interface			(Jeff Garzik)
- starfire,sundance,dl2k,sis900,8139{too,cp},
  natsemi driver updates			(Jeff Garzik)
- ufs/minix: mark inodes as bad in case of read
  failure					(Christoph Hellwig)
- ReiserFS fixes				(Oleg Drokin)
- sonypi update					(Stelian Pop)
- n_hdlc update					(Paul Fulghum)
- Fix compile error on aty_base.c		(Tobias Ringstrom)
- Document cpu_to_xxxx() on kernel-hacking doc  (Rusty Russell)
- USB update					(Greg KH)
- Fix sysctl console loglevel bug on 
  IA64 (and possibly other archs)		(Jesper Juhl) 
- Update Athlon/VIA PCI quirks			(Calin A. Culianu)
- blkmtd update					(Simon Evans)
- boot protocol update (makes the highest 
  possible initrd address available to the 
  bootloader)					(H. Peter Anvin)
- NFS fixes					(Trond Myklebust)

