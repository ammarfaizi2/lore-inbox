Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267008AbSLKEZy>; Tue, 10 Dec 2002 23:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267010AbSLKEZy>; Tue, 10 Dec 2002 23:25:54 -0500
Received: from pop016pub.verizon.net ([206.46.170.173]:15281 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S267008AbSLKEZw>; Tue, 10 Dec 2002 23:25:52 -0500
From: "Guillaume Boissiere" <boissiere@adiglobal.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 10 Dec 2002 23:33:31 -0500
MIME-Version: 1.0
Subject: [STATUS 2.5]  December 11, 2002
Message-ID: <3DF679CB.23987.80845E0@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop016.verizon.net from [64.152.17.166] at Tue, 10 Dec 2002 22:33:32 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The stabilization work has begun.  One item of interest this week
is the update to the new framebuffer/console API.
Full list is available at http://www.kernelnewbies.org/status/

Also, with more people testing different configurations, the 
number of bugs in bugzilla has increased quite a big since last 
week.  80 and counting.

Cheers,

-- Guillaume


---------------------------------
Linux Kernel 2.5 Status - December 11th, 2002
(Latest kernel release is 2.5.51)

Items in bold have changed since last week.

...
o in 2.5.48  In-kernel module loader  (Rusty Russell)  
o in 2.5.51  Compatibility syscall layer  (Stephen Rothwell)  
o in 2.5.51+  Rewrite of the console layer  (James Simmons)  

o in -mm  Page table sharing  (Daniel Phillips, Dave McCracken)  
o in -osdl  Build option for Linux Trace Toolkit (LTT)  (Karim Yaghmour)  
o in -osdl  Linux Kernel Crash Dumps  (Matt Robinson, LKCD team)  
o in -osdl  High resolution timers  (George Anzinger, etc.)  
o in -osdl  Kernel Probes (kprobes)  (Vamsi Krishna, kprobes team)  
o in -dcl  NUMA aware scheduler extensions  (Erich Focht, Michael Hohnbaum)  
 
o before 2.6.0  Support insane number of groups  (Tim Hockin)  
o before 2.6.0  Worldclass support for IPv6  (Alexey Kuznetsov, Dave Miller, Jun Murai, Yoshifuji Hideaki, USAGI team)  
o before 2.6.0  Reiserfs v4  (Reiserfs team)  
o before 2.6.0  32bit dev_t  (Al Viro)  
o before 2.6.0  Fix device naming issues  (Patrick Mochel, Greg Kroah-Hartman)  
o before 2.6.0  Change all drivers to new driver model  (All maintainers)  
o before 2.6.0  USB gadget support  (Stuart Lynne, Greg Kroah-Hartman)  
o before 2.6.0  Improved AppleTalk stack  (Arnaldo Carvalho de Melo)  
o before 2.6.0  ext2/ext3 online resize support  (Andreas Dilger)  


BUGZILLA:
13  blo  mbligh@aracnet.com  OPEN   user-mode-linux (ARCH=um) compile broken in 2.5.47  
44  blo  khoa@us.ibm.com  OPEN   radeonfb does not compile at all - seems incomplete? or w...  
66  blo  zaitcev@yahoo.com  ASSI   SMP Kernel Compile for Sparc32 fails  
118  blo  mbligh@aracnet.com  OPEN   Load IDE-SCSI module causes OOPS in 2.5.49  
123  blo  alan@lxorguk.ukuu.org.uk  ASSI   SiL 680 IDE controller has "issues"  
10  hig  andrew.grover@intel.com  ASSI   USB HCs may have improper interrupt configuration with AC...  
71  hig  andrew.grover@intel.com  ASSI   RTL8100BL (8139) do not work on acpi UP without local apic  
84  hig  zippel@linux-m68k.org  ASSI   qconf crashes when setting default NLS  
111  hig  wli@holomorphy.com  OPEN   hugetlbfs does not align pages  
113  hig  alan@lxorguk.ukuu.org.uk  OPEN   CMD649 or ALI15X3 problem under 2.5.49 and since many pre...  
129  hig  greg@kroah.com  OPEN   usb-storage crashes my pc when i plug in a SIIG Compact F...  
130  hig  green@namesys.com  ASSI   problems mounting root partition with 2.5.48+ kernels  
148  hig  mbligh@aracnet.com  OPEN   keyboard doesn't work  
157  hig  mbligh@aracnet.com  OPEN   Makefile bug? sound/synth/emux/built-in.o  
5  nor  mbligh@aracnet.com  ASSI   64GB highmem BUG()  
7  nor  willy@debian.org  ASSI   file lock accounting broken  
9  nor  dbrownell@users.sourceforge...  ASSI   Ehci do not leave system in a sensible state for bios on ...  
11  nor  mbligh@aracnet.com  OPEN   Intermezzo Compile Failure  
15  nor  alan@lxorguk.ukuu.org.uk  ASSI   No dma on first hard drive  
16  nor  willy@debian.org  ASSI   reproduceable oops in lock_get_status  
18  nor  mbligh@aracnet.com  OPEN   Synaptics touchpad driver  
19  nor  khoa@us.ibm.com  OPEN   aty128fb does not compile  
32  nor  khoa@us.ibm.com  OPEN   framebuffer drivers dont compile  
36  nor  andmike@us.ibm.com  ASSI   Long tape rewind causes abort on aic7xxx  
37  nor  alan@lxorguk.ukuu.org.uk  ASSI   IDE problems on old pre-PCI HW  
39  nor  alan@lxorguk.ukuu.org.uk  ASSI   undefined reference to `boot_gdt_table'  
42  nor  alan@lxorguk.ukuu.org.uk  ASSI   8139too ifconfig causes oops  
43  nor  jgarzik@pobox.com  ASSI   e100 drivers crashes on non cache-coherent platforms  
46  nor  mbligh@aracnet.com  OPEN   Two mice: unwanted double-clicks & erratic behavior  
48  nor  mbligh@aracnet.com  OPEN   APM suspend and PCMCIA not cooperating  
49  nor  mbligh@aracnet.com  OPEN   register_console() called in illegal context  
51  nor  paul@laufernet.com  ASSI   isapnp does not register devices in /proc/isapnp  
52  nor  andmike@us.ibm.com  ASSI   aic7xxx driver fails to boot on netfinity 7000  
53  nor  alan@lxorguk.ukuu.org.uk  ASSI   IDE cd-rom I/O error  
54  nor  mbligh@aracnet.com  OPEN   100% reproduceable "null TTY for (####) in tty_fasync"  
58  nor  mbligh@aracnet.com  OPEN   OHCI-1394: sleeping function called from illegal context ...  
63  nor  wli@holomorphy.com  OPEN   compile error with CONFIG_HUGETLB_PAGE yes  
69  nor  mbligh@aracnet.com  OPEN   Framebuffer bug  
72  nor  khoa@us.ibm.com  OPEN   Framebuffer scrolls at the wrong times/places  
79  nor  khoa@us.ibm.com  OPEN   Framebuffer scrolling problem  
94  nor  mbligh@aracnet.com  OPEN   file remain locked after sapdb process exist.  
100  nor  johnstul@us.ibm.com  ASSI   LTP - gettimeofday02 fails (time is going backwards)  
104  nor  khoa@us.ibm.com  OPEN   MIPS fails to build: asm/thread_info.h doesn't exist  
105  nor  johnstul@us.ibm.com  ASSI   gettimeofday cripples system running with notsc  
106  nor  mochel@osdl.org  OPEN   sysfs hierarchy can begin to disintegrate  
110  nor  khoa@us.ibm.com  OPEN   Current bk Linux-2.5, VFS Kernel Panic from Devfs + NO UN...  
115  nor  mbligh@aracnet.com  OPEN   Kernel modules won't load  
116  nor  rth@twiddle.net  OPEN   all mounts oops  
117  nor  mbligh@aracnet.com  OPEN   build failure: arch/ppc/kernel/process.c  
119  nor  andrew.grover@intel.com  OPEN   2.5.49 - Dell Latitude weirdness at shutdown  
122  nor  mbligh@aracnet.com  OPEN   emu10k1 OSS troubles  
126  nor  mbligh@aracnet.com  OPEN   bzImage build failure on input devices support as module  
131  nor  alan@lxorguk.ukuu.org.uk  OPEN   "hda: lost interrupt"; "hda: dma_intr: bad DMA status" on...  
132  nor  acme@conectiva.com.br  OPEN   windows ip check ARP packet replied by kernel when proxy_...  
134  nor  mbligh@aracnet.com  OPEN   2.5.50 breaks pcmcia cards  
135  nor  mbligh@aracnet.com  OPEN   SB16/Alsa doesn't work  
136  nor  akpm@digeo.com  OPEN   FSID returned from statvfs always 0  
138  nor  khoa@us.ibm.com  OPEN   Build error: drivers/video/sis/sis_main.h:299: parse erro...  
140  nor  andmike@us.ibm.com  OPEN   isp1020 driver reports error  
143  nor  alan@lxorguk.ukuu.org.uk  OPEN   unable to read cd audio from atapi cdrom/cdrw/dvd device,...  
144  nor  mbligh@aracnet.com  OPEN   error return not checked in register_disk (fs/partitions/...  
145  nor  mbligh@aracnet.com  OPEN   ALSA: SB-AWE ISA detection fails  
149  nor  mbligh@aracnet.com  OPEN   Laptop with touchpad and "pointer". Pointer never works  
150  nor  greg@kroah.com  OPEN   [PNP][2.5] IDE Detection problems (wrong IRQ and wrong ID...  
151  nor  axboe@suse.de  OPEN   compile failure on drivers/block/ps2esdi.c  
153  nor  rmk@arm.linux.org.uk  OPEN   compile failure on drivers/char/riscom8.c  
154  nor  rmk@arm.linux.org.uk  OPEN   compile failure on drivers/char/esp.c  
155  nor  rmk@arm.linux.org.uk  OPEN   compile failure on drivers/char/specialix.c  
156  nor  alan@lxorguk.ukuu.org.uk  ASSI   compile failure on drivers/ide/pci/nvidia.c  
158  nor  mbligh@aracnet.com  OPEN   depmod should be in README  
159  nor  mbligh@aracnet.com  OPEN   compile failure on drivers/isdn/i4l/isdn_net_lib.c  
8  low  alan@lxorguk.ukuu.org.uk  ASSI   i2o_scsi does not handle reset properly  
20  low  davej@codemonkey.org.uk  OPEN   Kernel AGP support needs to be initialized sooner  
28  low  jgarzik@pobox.com  ASSI   Compile time warnings from starfire driver (with PAE enab...  
29  low  akpm@digeo.com  ASSI   Debug: sleeping function called from illegal context at m...  
78  low  zippel@linux-m68k.org  ASSI   make dep on lk configuration exit  
83  low  zippel@linux-m68k.org  ASSI   Wish: ability to quickly cycle through (NEW) config options  
142  low  mbligh@aracnet.com  OPEN   problem with ver_linux script and procps version  
146  low  akpm@digeo.com  OPEN   Assertion failure in do_get_write_access() at fs/jbd/tra...  
152  low  zippel@linux-m68k.org  OPEN   make xconfig dont work  
80 bugs found. 


