Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267065AbSLDULx>; Wed, 4 Dec 2002 15:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267068AbSLDULx>; Wed, 4 Dec 2002 15:11:53 -0500
Received: from pop015pub.verizon.net ([206.46.170.172]:44684 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S267065AbSLDULu>; Wed, 4 Dec 2002 15:11:50 -0500
From: "Guillaume Boissiere" <boissiere@adiglobal.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 04 Dec 2002 15:18:44 -0500
MIME-Version: 1.0
Subject: [STATUS 2.5]  December 4, 2002
Message-ID: <3DEE1CD4.3794.8F165F3@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop015.verizon.net from [64.152.17.166] at Wed, 4 Dec 2002 14:19:14 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Of note this week the merge of the syscall compatibility layer.
Also more bug reports in bugzilla (http://bugme.odsl.org/), 
which probably means more people are testing 2.5 these days.

Full status list is at http://www.kernelnewbies.org/status/
Please let me know if anything is inaccurate or missing.
Cheers,

-- Guillaume


--------------------------------------
Linux Kernel 2.5 Status - December 4th, 2002
(Latest kernel release is 2.5.50)

o before 2.6.0  Rewrite of the console layer  (James Simmons)  
o before 2.6.0  Support insane number of groups  (Tim Hockin)  
o before 2.6.0  Worldclass support for IPv6  (Alexey Kuznetsov, Dave Miller, Jun Murai, Yoshifuji Hideaki, USAGI team)  
o before 2.6.0  Reiserfs v4  (Reiserfs team)  
o before 2.6.0  32bit dev_t  (Al Viro)  
o before 2.6.0  Fix device naming issues  (Patrick Mochel, Greg Kroah-Hartman)  
o before 2.6.0  Change all drivers to new driver model  (All maintainers)  
o before 2.6.0  USB gadget support  (Stuart Lynne, Greg Kroah-Hartman)  
o before 2.6.0  Improved AppleTalk stack  (Arnaldo Carvalho de Melo)  
o before 2.6.0  ext2/ext3 online resize support  (Andreas Dilger)  


BUGZILLA (bugs ordered by severity level):
13  blo  mbligh@aracnet.com  OPEN   user-mode-linux (ARCH=um) compile broken in 2.5.47  
44  blo  khoa@us.ibm.com  OPEN   radeonfb does not compile at all - seems incomplete? or w...  
118  blo  mbligh@aracnet.com  OPEN   Load IDE-SCSI module causes OOPS in 2.5.49  
66  blo  zaitcev@yahoo.com  ASSI   SMP Kernel Compile for Sparc32 fails  
123  blo  alan@lxorguk.ukuu.org.uk  ASSI   SiL 680 IDE controller has "issues"  
35  hig  mbligh@aracnet.com  OPEN   Riva Framebuffer doesn't compile  
111  hig  wli@holomorphy.com  OPEN   hugetlbfs does not align pages  
113  hig  alan@lxorguk.ukuu.org.uk  OPEN   CMD649 or ALI15X3 problem under 2.5.49 and since many pre...  
129  hig  greg@kroah.com  OPEN   usb-storage crashes my pc when i plug in a SIIG Compact F...  
10  hig  andrew.grover@intel.com  ASSI   USB HCs may have improper interrupt configuration with AC...  
71  hig  andrew.grover@intel.com  ASSI   RTL8100BL (8139) do not work on acpi UP without local apic  
84  hig  zippel@linux-m68k.org  ASSI   qconf crashes when setting default NLS  
130  hig  green@namesys.com  ASSI   problems mounting root partition with 2.5.48+ kernels  
11  nor  mbligh@aracnet.com  OPEN   Intermezzo Compile Failure  
18  nor  mbligh@aracnet.com  OPEN   Synaptics touchpad driver  
19  nor  khoa@us.ibm.com  OPEN   aty128fb does not compile  
32  nor  khoa@us.ibm.com  OPEN   framebuffer drivers dont compile  
46  nor  mbligh@aracnet.com  OPEN   Two mice: unwanted double-clicks & erratic behavior  
48  nor  mbligh@aracnet.com  OPEN   APM suspend and PCMCIA not cooperating  
49  nor  mbligh@aracnet.com  OPEN   register_console() called in illegal context  
54  nor  mbligh@aracnet.com  OPEN   100% reproduceable "null TTY for (####) in tty_fasync"  
58  nor  mbligh@aracnet.com  OPEN   OHCI-1394: sleeping function called from illegal context ...  
63  nor  wli@holomorphy.com  OPEN   compile error with CONFIG_HUGETLB_PAGE yes  
69  nor  mbligh@aracnet.com  OPEN   Framebuffer bug  
72  nor  khoa@us.ibm.com  OPEN   Framebuffer scrolls at the wrong times/places  
79  nor  khoa@us.ibm.com  OPEN   Framebuffer scrolling problem  
94  nor  mbligh@aracnet.com  OPEN   file remain locked after sapdb process exist.  
104  nor  khoa@us.ibm.com  OPEN   MIPS fails to build: asm/thread_info.h doesn't exist  
106  nor  mochel@osdl.org  OPEN   sysfs hierarchy can begin to disintegrate  
110  nor  khoa@us.ibm.com  OPEN   Current bk Linux-2.5, VFS Kernel Panic from Devfs + NO UN...  
115  nor  mbligh@aracnet.com  OPEN   Kernel modules won't load  
116  nor  rth@twiddle.net  OPEN   all mounts oops  
117  nor  mbligh@aracnet.com  OPEN   build failure: arch/ppc/kernel/process.c  
119  nor  andrew.grover@intel.com  OPEN   2.5.49 - Dell Latitude weirdness at shutdown  
122  nor  mbligh@aracnet.com  OPEN   emu10k1 OSS troubles  
126  nor  mbligh@aracnet.com  OPEN   bzImage build failure on input devices support as module  
128  nor  mbligh@aracnet.com  OPEN   2.5.50 CONFIG_ACPI_SLEEP fails to build without  
131  nor  alan@lxorguk.ukuu.org.uk  OPEN   "hda: lost interrupt"; "hda: dma_intr: bad DMA status" on...  
132  nor  acme@conectiva.com.br  OPEN   windows ip check ARP packet replied by kernel when proxy_...  
134  nor  mbligh@aracnet.com  OPEN   2.5.50 breaks pcmcia cards  
135  nor  mbligh@aracnet.com  OPEN   SB16/Alsa doesn't work  
136  nor  akpm@digeo.com  OPEN   FSID returned from statvfs always 0  
5  nor  mbligh@aracnet.com  ASSI   64GB highmem BUG()  
7  nor  willy@debian.org  ASSI   file lock accounting broken  
9  nor  dbrownell@users.sourceforge...  ASSI   Ehci do not leave system in a sensible state for bios on ...  
15  nor  alan@lxorguk.ukuu.org.uk  ASSI   No dma on first hard drive  
16  nor  willy@debian.org  ASSI   reproduceable oops in lock_get_status  
36  nor  andmike@us.ibm.com  ASSI   Long tape rewind causes abort on aic7xxx  
37  nor  alan@lxorguk.ukuu.org.uk  ASSI   IDE problems on old pre-PCI HW  
39  nor  alan@lxorguk.ukuu.org.uk  ASSI   undefined reference to `boot_gdt_table'  
42  nor  alan@lxorguk.ukuu.org.uk  ASSI   8139too ifconfig causes oops  
43  nor  jgarzik@pobox.com  ASSI   e100 drivers crashes on non cache-coherent platforms  
51  nor  paul@laufernet.com  ASSI   isapnp does not register devices in /proc/isapnp  
52  nor  andmike@us.ibm.com  ASSI   aic7xxx driver fails to boot on netfinity 7000  
53  nor  alan@lxorguk.ukuu.org.uk  ASSI   IDE cd-rom I/O error  
100  nor  johnstul@us.ibm.com  ASSI   LTP - gettimeofday02 fails (time is going backwards)  
105  nor  johnstul@us.ibm.com  ASSI   gettimeofday cripples system running with notsc  
20  low  khoa@us.ibm.com  OPEN   Kernel AGP support needs to be initialized sooner  
8  low  alan@lxorguk.ukuu.org.uk  ASSI   i2o_scsi does not handle reset properly  
28  low  jgarzik@pobox.com  ASSI   Compile time warnings from starfire driver (with PAE enab...  
29  low  akpm@digeo.com  ASSI   Debug: sleeping function called from illegal context at m...  
78  low  zippel@linux-m68k.org  ASSI   make dep on lk configuration exit  
83  low  zippel@linux-m68k.org  ASSI   Wish: ability to quickly cycle through (NEW) config options  
63 bugs found.
