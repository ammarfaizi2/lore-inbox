Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289037AbSBDUzI>; Mon, 4 Feb 2002 15:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288897AbSBDUy7>; Mon, 4 Feb 2002 15:54:59 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:59404 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S289037AbSBDUyq>; Mon, 4 Feb 2002 15:54:46 -0500
Date: Mon, 4 Feb 2002 17:44:17 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.18-pre8
Message-ID: <Pine.LNX.4.21.0202041743180.14205-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

No more big patches for 2.4.18, please... We are getting close to the -rc
stage.

pre8: 

- Add missing netfilter files in pre7 		(David S. Miller)
- SunGEM driver update				(David S. Miller)
- Kill get_fast_time				(David S. Miller)
- Update APIC LVTERR fix to work correctly on 
  old 486/586 APICs				(Mikael Pettersson)
- Check the return code of copy_{from,to}_user
  on serial code				(Rasmus Andersen)
- Mark 2.5 extended attributes system calls as 
  reserved to avoid potential conflicts		(Nathan Scott)
- Change Christoph Hellwig's email address	(Christoph Hellwig)
- Make BLKGETSIZE64 return size in bytes not 
  sectors					(Eric Sandeen)
- Coda dentry revalidation fix			(Jan Harkes)
- hisax_fcpcipnp driver update			(Kai Germaschewski)
- i810 sound driver update			(Doug Ledford)
- Early personality setting in binfmt_elf	(Christoph Hellwig)
- Fix rename bug in reiserfs			(Oleg Drokin)
- SCSI documentation update			(Douglas Gilbert)
- Fix silly typo in megaraid driver 		(Arjan Van de Ven)
- PPC update					(Benjamin Herrenschmidt)
- USB bug fixes					(Greg KH)
- Fix devfs problems with removable devices	(Richard Gooch)
- Merge -ac1 fixes				(Alan Cox)
- VXFS update					(Christoph Hellwig)
- Add Compaq FC array to the LUN whitelist	(Arjan Van de Ven) 

pre7:

- Make ext2/minix/sysvfs actually operate
  synchronously on directories when using
  the sync mount option				(Andrew Morton)
- AFFS update					(Roman Zippel)
- Fix 3dfx fb crash with high pixelclock 	(Jurriaan on Alpha)
- PATH_MAX POSIX compliance			(Rusty Russell)
- Really apply AMD Elan patch			(me)
- Don't drop IP packets with less than 8 bytes 
  of payload 					(David S. Miller)
- Netfilter update 				(Netfilter team)
- Backport 2.5 sb_bread() changes		(Alexander Viro)
- Fix AF_UNIX fd leak				(David S. Miller)
- Add Audigy Gameport PCI ID	 		(Daniel Bertrand)
- Sync with ia64 arch independant parts		(Keith Owens)
- APM fixes					(Stephen Rothwell)
- fs/super.c cleanups				(Alexander Viro)

pre6:

- Removed patch in icmp code: its
  not needed and causes problems                (me)

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

