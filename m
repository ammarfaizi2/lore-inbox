Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136791AbRAHFMw>; Mon, 8 Jan 2001 00:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136846AbRAHFMn>; Mon, 8 Jan 2001 00:12:43 -0500
Received: from frontier.axistangent.net ([63.101.14.200]:44279 "EHLO
	foozle.turbogeek.org") by vger.kernel.org with ESMTP
	id <S136791AbRAHFM3>; Mon, 8 Jan 2001 00:12:29 -0500
Date: Sun, 7 Jan 2001 23:12:28 -0600
From: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
To: linux-kernel@vger.kernel.org
Cc: axel@uni-paderborn.de
Subject: Re: [PATCH] More Configure.help fixes
Message-ID: <20010107231228.A8927@foozle.turbogeek.org>
In-Reply-To: <20010107225730.A8883@foozle.turbogeek.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010107225730.A8883@foozle.turbogeek.org>; from jmd@foozle.turbogeek.org on Sun, Jan 07, 2001 at 10:57:30PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As per usual, when sending a mail with an attachment, I forgot to
attach it after I :wq'd.

-- 
Jeremy M. Dolan <jmd@turbogeek.org>
OpenPGP key = http://turbogeek.org/openpgp-key
OpenPGP fingerprint = 494C 7A6E 19FB 026A 1F52  E0D5 5C5D 6228 DC43 3DEE

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="Configure.help-jmd.diff"
Content-Transfer-Encoding: 8bit

diff -rub 2.4.0/Documentation/Configure.help linux/Documentation/Configure.help
--- 2.4.0/Documentation/Configure.help	Fri Jan  5 09:19:30 2001
+++ linux/Documentation/Configure.help	Sun Jan  7 22:13:09 2001
@@ -1,7 +1,7 @@
 # Maintained by Axel Boldt (axel@uni-paderborn.de)
 #
 # This version of the Linux kernel configuration help texts
-# corresponds to the kernel versions 2.3.x.
+# corresponds to the kernel versions 2.4.x.
 #
 # Translations of this file available on the WWW:
 #
@@ -13,8 +13,10 @@
 #     http://www.traduc.org/kernelfr
 #   - Spanish, by Carlos Perelló Marín (fperllo@ehome.encis.es), at
 #     http://visar.csustan.edu/~carlos/
+#     XXX: Site has moved, new location has no Configure.help trans.
 #   - Italian, by Alessandro Rubini (rubini@linux.it), at
 #     ftp://ftp-pavia1.linux.it/pub/linux/Configure.help
+#     XXX: ftp-pavia1.linux.it: Non-existent host/domain
 #   - Polish, by Cezar Cichocki (cezar@cs.net.pl), at
 #     http://www.cs.net.pl/~cezar/Kernel
 #   - German, by SuSE, at http://www.suse.de/~ke/kernel . This patch
@@ -113,8 +115,8 @@
   Management" code will be disabled if you say Y here.
 
   See also the files Documentation/smp.tex, Documentation/smp.txt,
-  Documentation/i386/IO-APIC.txt, Documentation/nmi_watchdog.txt and the 
-  SMP-FAQ on the WWW at http://www.irisa.fr/prive/mentre/smp-faq/ .
+  Documentation/i386/IO-APIC.txt, Documentation/nmi_watchdog.txt and
+  the SMP-FAQ on the WWW at http://www.irisa.fr/prive/mentre/smp-faq/
   
   If you don't know what to do here, say N.
   
@@ -1514,7 +1516,7 @@
 CONFIG_RAID15_DANGEROUS
   This new RAID1/RAID5 code has been freshly merged, and has not seen
   enough testing yet. While there are no known bugs in it, it might
-  destroy your filesystems, eat your data and start World War III.
+  destroy your file systems, eat your data and start World War III.
   You have been warned.
 
   If unsure, say N.
@@ -1879,8 +1881,8 @@
 
 MAC address match support
 CONFIG_IP_NF_MATCH_MAC
-  mac matching allows you to match packets based on the source
-  ethernet address of the packet.
+  MAC matching allows you to match packets based on the source
+  Ethernet address of the packet.
 
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt.  If unsure, say `N'.
@@ -4175,7 +4177,7 @@
   packets with different FWMARK ("firewalling mark") values
   (see ipchains(8), "-m" argument).
 
-Appletalk interfaces support
+AppleTalk interfaces support
 CONFIG_APPLETALK
   AppleTalk is the way Apple computers speak to each other on a
   network. If your Linux box is connected to such a network and you
@@ -4790,7 +4792,7 @@
 
 Routing messages
 CONFIG_RTNETLINK
-  If you say Y here, userspace programs can receive some network
+  If you say Y here, user space programs can receive some network
   related routing information over the netlink. 'rtmon', supplied
   with the iproute2 package (ftp://ftp.inr.ac.ru), can read and
   interpret this data.  Information sent to the kernel over this link
@@ -6880,7 +6882,7 @@
   PPP (Point to Point Protocol) is a newer and better SLIP. It serves
   the same purpose: sending Internet traffic over telephone (and other
   serial) lines. Ask your access provider if they support it, because
-  otherwise you can't use it; most internet access providers these
+  otherwise you can't use it; most Internet access providers these
   days support PPP rather than SLIP.
 
   To use PPP, you need an additional program called pppd as described
@@ -9883,7 +9885,7 @@
 Memory Technology Device (MTD) support
 CONFIG_MTD
   Memory Technology Devices are flash, RAM and similar chips, often
-  used for solid state filesystems on embedded devices. This option
+  used for solid state file systems on embedded devices. This option
   will provide the generic support for MTD drivers to register
   themselves with the kernel and for potential users of MTD devices
   to enumerate the devices which are present and obtain a handle on
@@ -9900,14 +9902,14 @@
   This provides an MTD device driver for the M-Systems DiskOnChip
   2000 devices. If you use this, you probably also want the NFTL
   'NAND Flash Translation Layer' below, which is used to emulate
-  a block device by using a kind of filesystem on the flash chips.
+  a block device by using a kind of file system on the flash chips.
 
 M-Systems Disk-On-Chip Millennium support
 CONFIG_MTD_DOC2001
   This provides an MTD device driver for the M-Systems DiskOnChip
   Millennium devices. If you use this, you probably also want the
   NFTL 'NAND Flash Translation Layer' below, which is used to emulate
-  a block device by using a kind of filesystem on the flash chips.
+  a block device by using a kind of file system on the flash chips.
 
 Use extra onboard system memory as MTD device
 CONFIG_MTD_SLRAM
@@ -10023,15 +10025,15 @@
 
   Later, it may be extended to perform read/erase/modify/write cycles
   on flash chips to emulate a smaller block size. Needless to say,
-  this is very unsafe, but could be useful for filesystems which are
+  this is very unsafe, but could be useful for file systems which are
   almost never written to.
 
 FTL (Flash Translation Layer) support
 CONFIG_FTL
   This provides support for the original Flash Translation Layer which
   is part of the PCMCIA specification. It uses a kind of pseudo-
-  filesystem on a flash device to emulate a block device with 512-byte
-  sectors, on top of which you put a 'normal' filesystem. You may find
+  file system on a flash device to emulate a block device with 512-byte
+  sectors, on top of which you put a 'normal' file system. You may find
   that the algorithms used in this code are patented unless you live
   in the Free World where software patents aren't legal - in the USA
   you are only permitted to use this on PCMCIA hardware, although 
@@ -10042,8 +10044,8 @@
 CONFIG_NFTL
   This provides support for the NAND Flash Translation Layer which is
   used on M-Systems' DiskOnChip devices. It uses a kind of pseudo-
-  filesystem on a flash device to emulate a block device with 512-byte
-  sectors, on top of which you put a 'normal' filesystem. You may find
+  file system on a flash device to emulate a block device with 512-byte
+  sectors, on top of which you put a 'normal' file system. You may find
   that the algorithms used in this code are patented unless you live
   in the Free World where software patents aren't legal - in the USA
   you are only permitted to use this on DiskOnChip hardware, although 
@@ -11756,7 +11758,7 @@
 
 nls default codepage
 CONFIG_NLS_DEFAULT
-  The default NLS used when mounting filesystem. Currently, the valid
+  The default NLS used when mounting file system. Currently, the valid
   values are:
   big5, cp437, cp737, cp775, cp850, cp852, cp855, cp857, cp860, cp861,
   cp862, cp863, cp864, cp865, cp866, cp869, cp874, cp932, cp936,
@@ -11945,7 +11947,7 @@
 
 nls codepage 932
 CONFIG_NLS_CODEPAGE_932
-  The Microsoft fat filesystem family can deal with filenames in
+  The Microsoft FAT file system family can deal with filenames in
   native language character sets. These character sets are stored in
   so-called DOS codepages. You need to include the appropriate
   codepage if you want to be able to read/write these filenames on
@@ -11957,7 +11959,7 @@
 
 nls codepage 936
 CONFIG_NLS_CODEPAGE_936
-  The Microsoft fat filesystem family can deal with filenames in
+  The Microsoft FAT file system family can deal with filenames in
   native language character sets. These character sets are stored in
   so-called DOS codepages. You need to include the appropriate
   codepage if you want to be able to read/write these filenames on
@@ -11968,7 +11970,7 @@
 
 nls codepage 949
 CONFIG_NLS_CODEPAGE_949
-  The Microsoft fat filesystem family can deal with filenames in
+  The Microsoft FAT file system family can deal with filenames in
   native language character sets. These character sets are stored in
   so-called DOS codepages. You need to include the appropriate
   codepage if you want to be able to read/write these filenames on
@@ -11978,7 +11980,7 @@
 
 nls codepage 950
 CONFIG_NLS_CODEPAGE_950
-  The Microsoft fat filesystem family can deal with filenames in
+  The Microsoft FAT file system family can deal with filenames in
   native language character sets. These character sets are stored in
   so-called DOS codepages. You need to include the appropriate
   codepage if you want to be able to read/write these filenames on
@@ -13508,7 +13510,7 @@
   is used to set the BIOS and power saving options on Toshiba portables.
 
   For information on utilities to make use of this driver see the
-  Toshiba Linux utilities website at:
+  Toshiba Linux utilities web site at:
   http://www.buzzard.org.uk/toshiba/
 
 /dev/cpu/microcode - Intel IA32 CPU microcode support
@@ -17086,7 +17088,7 @@
 # LocalWords:  howto multicasting MULTICAST MBONE firewalling ipfw ACCT resp ip
 # LocalWords:  proc acct IPIP encapsulator decapsulator klogd PCTCP RARP EXT PS
 # LocalWords:  telnetting subnetted NAGLE rlogin NOSR ttyS TGA techinfo mbone nl
-# LocalWords:  Mb SKB IPX Novell dosemu Appletalk DDP ATALK vmalloc visar ehome
+# LocalWords:  Mb SKB IPX Novell dosemu DDP ATALK vmalloc visar ehome
 # LocalWords:  SD CHR scsi thingy SG CD LUNs LUN jukebox Adaptec BusLogic EATA
 # LocalWords:  buslogic DMA DPT ATT eata dma PIO UltraStor fdomain umsdos ext
 # LocalWords:  QLOGIC qlogic TMC seagate Trantor ultrastor FASST wd NETDEVICES
@@ -17114,7 +17116,7 @@
 # LocalWords:  Brumby pci TNC cis ohio faq usenet NETLINK dev hydra ca Tyne mem
 # LocalWords:  carleton DECstation SUNFD JENSEN Noname XXXM SLiRP LILO's amifb
 # LocalWords:  pppd Zilog ZS SRM bootloader ez mainmenu rarp ipfwadm paride pcd
-# LocalWords:  RTNETLINK mknod xos MTU lwared Macs mac netatalk macs cs Wolff
+# LocalWords:  RTNETLINK mknod xos MTU lwared Macs netatalk macs cs Wolff
 # LocalWords:  dartmouth flowerpt MultiMaster FlashPoint tudelft etherexpress
 # LocalWords:  ICL EtherTeam ETH IDESCSI TXC SmartRAID SmartCache httpd sjc dlp
 # LocalWords:  thesphere TwoServers BOOTP DHCP ncpfs BPQETHER BPQ MG HIPPI cern
@@ -17131,7 +17133,7 @@
 # LocalWords:  Keepalive linefill RELCOM keepalive analogue CDR conf CDI INIT
 # LocalWords:  OPTi isp irq noisp VFAT vfat NTFS losetup dmsdosfs dosfs ISDN MP
 # LocalWords:  NOWAYOUT behaviour dialin isdn callback BTX Teles  XXXX LVM lvm
-ICN EDSS Cisco
+# LocalWords:  ICN EDSS Cisco
 # LocalWords:  ipppd syncppp RFC MPP VJ downloaded icn NICCY Creatix shmem ufr
 # LocalWords:  ibp md ARCnet ether encap NDIS arcether ODI Amigas AmiTCP NetBSD
 # LocalWords:  initrd tue util DES funet des OnNet BIOSP smc Travan Iomega CMS

--MGYHOYXEY6WxJCY8--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
