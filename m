Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbSK0R5E>; Wed, 27 Nov 2002 12:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbSK0R5E>; Wed, 27 Nov 2002 12:57:04 -0500
Received: from pop016pub.verizon.net ([206.46.170.173]:8936 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S261600AbSK0R5C>; Wed, 27 Nov 2002 12:57:02 -0500
From: "Guillaume Boissiere" <boissiere@adiglobal.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 27 Nov 2002 13:04:13 -0500
MIME-Version: 1.0
Subject: [STATUS 2.5]  November 27, 2002
Message-ID: <3DE4C2CD.8610.92EA5BA5@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop016.verizon.net from [64.152.17.166] at Wed, 27 Nov 2002 12:04:16 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Things seem to be stabilizing quite a bit.  No new 
features but tons of bug fixes have been merged. 
Below the list of what I have pending in the status list 
along with the 58 open bugs currently in Bugzilla 
(http://bugzilla.kernel.org/)

Full status list is at http://www.kernelnewbies.org/status

Enjoy!

-- Guillaume


-------------------------
Linux Kernel 2.5 Status - November 27th, 2002
(Latest kernel release is 2.5.49)

o before 2.6.0  Rewrite of the console layer  (James Simmons)  
o before 2.6.0  Support insane number of groups  (Tim Hockin)  
o before 2.6.0  SCSI and FibreChannel Hotswap Support  (Steven Dake)  
o before 2.6.0  Worldclass support for IPv6  (Alexey Kuznetsov, Dave Miller, Jun Murai, Yoshifuji Hideaki, USAGI team)  
o before 2.6.0  Reiserfs v4  (Reiserfs team)  
o before 2.6.0  32bit dev_t  (Al Viro)  
o before 2.6.0  Fix device naming issues  (Patrick Mochel, Greg Kroah-Hartman)  
o before 2.6.0  Change all drivers to new driver model  (All maintainers)  
o before 2.6.0  USB gadget support  (Stuart Lynne, Greg Kroah-Hartman)  
o before 2.6.0  Improved AppleTalk stack  (Arnaldo Carvalho de Melo)  
o before 2.6.0  ext2/ext3 online resize support  (Andreas Dilger)  

BUGZILLA:
3  nor  dmccr@us.ibm.com  ASSI   Enabling shared pagetables causes KDE to wierd out  
5  nor  mbligh@aracnet.com  ASSI   64GB highmem BUG()  
7  nor  willy@debian.org  ASSI   file lock accounting broken  
8  low  alan@lxorguk.ukuu.org.uk  ASSI   i2o_scsi does not handle reset properly  
9  nor  dbrownell@users.sourceforge...  ASSI   Ehci do not leave system in a sensible state for bios on ...  
10  hig  andrew.grover@intel.com  ASSI   USB HCs may have improper interrupt configuration with AC...  
11  nor  mbligh@aracnet.com  OPEN   Intermezzo Compile Failure  
13  blo  mbligh@aracnet.com  OPEN   user-mode-linux (ARCH=um) compile broken in 2.5.47  
15  nor  alan@lxorguk.ukuu.org.uk  ASSI   No dma on first hard drive  
16  nor  willy@debian.org  ASSI   reproduceable oops in lock_get_status  
18  nor  mbligh@aracnet.com  OPEN   Synaptics touchpad driver  
19  nor  khoa@us.ibm.com  OPEN   aty128fb does not compile  
20  low  khoa@us.ibm.com  OPEN   Kernel AGP support needs to be initialized sooner  
28  low  jgarzik@pobox.com  ASSI   Compile time warnings from starfire driver (with PAE enab...  
29  low  akpm@digeo.com  ASSI   Debug: sleeping function called from illegal context at m...  
32  nor  khoa@us.ibm.com  OPEN   framebuffer drivers dont compile  
35  hig  mbligh@aracnet.com  OPEN   Riva Framebuffer doesn't compile  
36  nor  andmike@us.ibm.com  ASSI   Long tape rewind causes abort on aic7xxx  
37  nor  alan@lxorguk.ukuu.org.uk  ASSI   IDE problems on old pre-PCI HW  
39  nor  alan@lxorguk.ukuu.org.uk  ASSI   undefined reference to `boot_gdt_table'  
42  nor  alan@lxorguk.ukuu.org.uk  ASSI   8139too ifconfig causes oops  
43  nor  jgarzik@pobox.com  ASSI   e100 drivers crashes on non cache-coherent platforms  
44  blo  khoa@us.ibm.com  OPEN   radeonfb does not compile at all - seems incomplete? or w...  
46  nor  mbligh@aracnet.com  OPEN   Two mice: unwanted double-clicks & erratic behavior  
48  nor  mbligh@aracnet.com  OPEN   APM suspend and PCMCIA not cooperating  
49  nor  mbligh@aracnet.com  OPEN   register_console() called in illegal context  
51  nor  paul@laufernet.com  ASSI   isapnp does not register devices in /proc/isapnp  
52  nor  andmike@us.ibm.com  ASSI   aic7xxx driver fails to boot on netfinity 7000  
53  nor  alan@lxorguk.ukuu.org.uk  ASSI   IDE cd-rom I/O error  
54  nor  mbligh@aracnet.com  OPEN   100% reproduceable "null TTY for (####) in tty_fasync"  
58  nor  mbligh@aracnet.com  OPEN   OHCI-1394: sleeping function called from illegal context ...  
63  nor  wli@holomorphy.com  OPEN   compile error with CONFIG_HUGETLB_PAGE yes  
66  blo  zaitcev@yahoo.com  ASSI   SMP Kernel Compile for Sparc32 fails  
69  nor  mbligh@aracnet.com  OPEN   Framebuffer bug  
71  hig  andrew.grover@intel.com  ASSI   RTL8100BL (8139) do not work on acpi UP without local apic  
72  nor  khoa@us.ibm.com  OPEN   Framebuffer scrolls at the wrong times/places  
78  low  zippel@linux-m68k.org  ASSI   make dep on lk configuration exit  
79  nor  khoa@us.ibm.com  OPEN   Framebuffer scrolling problem  
83  low  zippel@linux-m68k.org  ASSI   Wish: ability to quickly cycle through (NEW) config options  
84  hig  zippel@linux-m68k.org  ASSI   qconf crashes when setting default NLS  
89  nor  mochel@osdl.org  OPEN   writing to sysfs appears to hang  
94  nor  mbligh@aracnet.com  OPEN   file remain locked after sapdb process exist.  
100  nor  johnstul@us.ibm.com  ASSI   LTP - gettimeofday02 fails (time is going backwards)  
102  hig  mbligh@aracnet.com  OPEN   Read from a raid 0 array failed.  
104  nor  khoa@us.ibm.com  OPEN   MIPS fails to build: asm/thread_info.h doesn't exist  
105  nor  johnstul@us.ibm.com  ASSI   gettimeofday cripples system running with notsc  
106  nor  mochel@osdl.org  OPEN   sysfs hierarchy can begin to disintegrate  
110  nor  khoa@us.ibm.com  OPEN   Current bk Linux-2.5, VFS Kernel Panic from Devfs + NO UN...  
111  hig  wli@holomorphy.com  OPEN   hugetlbfs does not align pages  
113  hig  alan@lxorguk.ukuu.org.uk  OPEN   CMD649 or ALI15X3 problem under 2.5.49 and since many pre...  
114  nor  mbligh@aracnet.com  OPEN   2.5.49 unable to mount XFS partition  
115  nor  mbligh@aracnet.com  OPEN   Kernel modules won't load  
116  nor  rth@twiddle.net  OPEN   all mounts oops  
117  nor  mbligh@aracnet.com  OPEN   build failure: arch/ppc/kernel/process.c  
118  hig  mbligh@aracnet.com  OPEN   Load IDE-SCSI module causes OOPS in 2.5.49  
119  nor  andrew.grover@intel.com  OPEN   2.5.49 - Dell Latitude weirdness at shutdown  
120  nor  mbligh@aracnet.com  OPEN   build fail  
122  nor  mbligh@aracnet.com  OPEN   emu10k1 OSS troubles  
58 bugs found. 



