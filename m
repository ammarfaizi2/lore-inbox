Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135733AbRAGFIF>; Sun, 7 Jan 2001 00:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135760AbRAGFHz>; Sun, 7 Jan 2001 00:07:55 -0500
Received: from linux.sisa.be ([194.88.100.134]:48901 "HELO socrates.sisa.be")
	by vger.kernel.org with SMTP id <S135733AbRAGFHp>;
	Sun, 7 Jan 2001 00:07:45 -0500
Message-ID: <20010107050746.11192.qmail@mail.mind.be>
Date: Sun, 7 Jan 2001 06:07:46 +0100 (CET)
From: Dag Wieers <dag@mind.be>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Mostly documentation fixes
User-Agent: Mutt/1.2i
X-Mailer: Evolution 1.0 (Stable release)
Organization: Mind Linux Solutions in Leuven/Belgium - http://mind.be/
X-Extra: If you can read this and Linux is your thing. Work for us !
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- drivers/net/eepro.c.orig	Sun Jan  7 04:34:40 2001
+++ drivers/net/eepro.c	Sun Jan  7 04:35:22 2001
@@ -323,7 +323,7 @@
 allowing up to 8K worth of packets to be queued.

 The sizes of the receive and transmit buffers can now be changed via lilo
-or insmod.  Lilo uses the appended line "ether=io,irq,debug,rx-buffer,eth0"
+or insmod.  Lilo uses the appended line "ether=irq,io,debug,rx-buffer,eth0"
 where rx-buffer is in KB unit.  Modules uses the parameter mem which is
 also in KB unit, for example "insmod io=io-address irq=0 mem=rx-buffer."
 The receive buffer has to be more than 3K or less than 29K.  Otherwise,
--- Documentation/kernel-parameters.txt.orig	Sun Jan  7 04:34:46 2001
+++ Documentation/kernel-parameters.txt	Sun Jan  7 04:35:38 2001
@@ -188,7 +188,7 @@

 	es1371=		[HW,SOUND]

-	ether=		[HW,NET] Ethernet cards parameters (iomem, irq,
+	ether=		[HW,NET] Ethernet cards parameters (irq, iomem,
 			dev_name).

 	fd_mcs=		[HW,SCSI]
--- MAINTAINERS.orig	Sun Jan  7 05:08:30 2001
+++ MAINTAINERS	Sun Jan  7 05:10:18 2001
@@ -906,8 +906,8 @@
 S:	Maintained

 OLYMPIC NETWORK DRIVER
-P:	Peter De Shrijver
-M:	p2@ace.ulyssis.sutdent.kuleuven.ac.be
+P:	Peter De Schrijver
+M:	p2@ace.ulyssis.student.kuleuven.ac.be
 P:	Mike Phillips
 M:	phillim@amtrak.com
 L:	linux-net@vger.kernel.org
--- Documentation/Configure.help.orig	Sun Jan  7 03:30:14 2001
+++ Documentation/Configure.help	Sun Jan  7 05:00:51 2001
@@ -1655,12 +1655,12 @@
 CONFIG_SGI_SN0_N_MODE
   The nodes of Origin 200, Origin 2000 and Onyx 2 systems can be
   configured in either N-Modes which allows for more nodes or M-Mode
-  which allows for more more memory.  Your system is most probably
+  which allows for more memory.  Your system is most probably
   running in M-Mode, so you should say N here.

 MIPS JAZZ onboard SONIC Ethernet support
 CONFIG_MIPS_JAZZ_SONIC
-  This is the driver for the onboard card of of MIPS Magnum 4000,
+  This is the driver for the onboard card of MIPS Magnum 4000,
   Acer PICA, Olivetti M700-10 and a few other identical OEM systems.

 MIPS JAZZ FAS216 SCSI support
@@ -2011,7 +2011,7 @@
 CONFIG_IP_NF_TARGET_MARK
   This option adds a `MARK' target, which allows you to create rules
   in the `mangle' table which alter the netfilter mark (nfmark) field
-  associated with the packet packet prior to routing. This can change
+  associated with the packet prior to routing. This can change
   the routing method (see `IP: use netfilter MARK value as routing
   key') and can also be used by other subsystems to change their
   behavior.
@@ -9529,7 +9529,7 @@

   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
-  The module will will be called olympic.o. If you want to compile it
+  The module will be called olympic.o. If you want to compile it
   as a module, say M here and read Documentation/modules.txt.

   Also read the file Documentation/networking/olympic.txt or check the
@@ -9569,7 +9569,7 @@

   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
-  The module will will be called tms380tr.o. If you want to compile it
+  The module will be called tms380tr.o. If you want to compile it
   as a module, say M here and read Documentation/modules.txt.

 Generic TMS380 PCI support
@@ -9584,7 +9584,7 @@

   This driver is available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
-  The module will will be called tmspci.o. If you want to compile it
+  The module will be called tmspci.o. If you want to compile it
   as a module, say M here and read Documentation/modules.txt.

 Madge Smart 16/4 PCI Mk2 support
@@ -9594,7 +9594,7 @@

   This driver is available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
-  The module will will be called abyss.o. If you want to compile it
+  The module will be called abyss.o. If you want to compile it
   as a module, say M here and read Documentation/modules.txt.

 Madge Smart 16/4 Ringode MicroChannel
@@ -9604,7 +9604,7 @@

   This driver is available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
-  The module will will be called madgemc.o. If you want to compile it
+  The module will be called madgemc.o. If you want to compile it
   as a module, say M here and read Documentation/modules.txt.

 SMC ISA TokenRing adapter support
@@ -9620,7 +9620,7 @@

   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
-  The module will will be called smctr.o. If you want to compile it
+  The module will be called smctr.o. If you want to compile it
   as a module, say M here and read Documentation/modules.txt.

 Sun Happy Meal 10/100baseT support
@@ -14591,7 +14591,7 @@

 SC-6600 CDROM Interface
 CONFIG_SC6600_CDROM
-  This is used to activate the the CDROM interface of the Audio Excel
+  This is used to activate the CDROM interface of the Audio Excel
   DSP 16 card. Enter: 0 for Sony, 1 for Panasonic, 2 for IDE, 4 for no
   CDROM present.

--- Documentation/modules.txt.orig	Sun Jan  7 05:38:27 2001
+++ Documentation/modules.txt	Sun Jan  7 05:48:49 2001
@@ -137,6 +137,39 @@
 since umsdos runs piggyback on msdos.


+Using modinfo:
+--------------
+
+Sometimes you need to know what parameters are accepted by a
+module or you've found a bug and want to contact the maintainer.
+Then modinfo comes in very handy.
+
+Every module (normally) contains the author/maintainer,
+a description and a list of parameters.
+
+For example "modinfo -a eepro100" will return:
+
+	Maintainer: Andrey V. Savochkin <saw@saw.sw.com.sg>
+
+and "modinfo -d eepro100" will return a description:
+
+	Intel i82557/i82558 PCI EtherExpressPro driver
+
+and more important "modinfo -p eepro100" will return this list:
+
+	debug int
+	options int array (min = 1, max = 8)
+	full_duplex int array (min = 1, max = 8)
+	congenb int
+	txfifo int
+	rxfifo int
+	txdmacount int
+	rxdmacount int
+	rx_copybreak int
+	max_interrupt_work int
+	multicast_filter_limit int
+
+
 The "ultimate" utility:
 -----------------------

--- Documentation/DocBook/kernel-hacking.tmpl.orig	Sun Jan  7 05:57:10 2001
+++ Documentation/DocBook/kernel-hacking.tmpl	Sun Jan  7 05:57:18 2001
@@ -1179,7 +1179,7 @@
      You may well want to make your CONFIG option only visible if
      <symbol>CONFIG_EXPERIMENTAL</symbol> is enabled: this serves as a
      warning to users.  There many other fancy things you can do: see
-     the the various <filename>Config.in</filename> files for ideas.
+     the various <filename>Config.in</filename> files for ideas.
     </para>
    </listitem>

--- Documentation/DocBook/kernel-locking.tmpl.orig	Sun Jan  7 05:58:48 2001
+++ Documentation/DocBook/kernel-locking.tmpl	Sun Jan  7 05:58:55 2001
@@ -386,7 +386,7 @@
        <function>spin_lock()</function> and
        <function>spin_unlock()</function> calls.
        <function>spin_lock_bh()</function> is
-       unnecessary here, as you are already in a a tasklet, and
+       unnecessary here, as you are already in a tasklet, and
        none will be run on the same CPU.
      </para>
     </sect2>

--  dag wieers, <dag@mind.be>, http://mind.be/  --
            Out of swap, out of luck.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
