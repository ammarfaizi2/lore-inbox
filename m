Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280940AbRKLTRe>; Mon, 12 Nov 2001 14:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280941AbRKLTR2>; Mon, 12 Nov 2001 14:17:28 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:26388 "EHLO
	tsmtp6.mail.isp") by vger.kernel.org with ESMTP id <S280940AbRKLTRP>;
	Mon, 12 Nov 2001 14:17:15 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Antoni Bella <bella5@teleline.es>
Organization: P&S - Lliure
To: linux-kernel@vger.kernel.org
Subject: [bugs] Configure.help version 2.49
Date: Mon, 12 Nov 2001 19:33:45 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01111219334500.02007@alba>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


  Hello

  I found bugs in to new format.

###############################
- --- /home/usuaris/toni/nucli_report/Configure.help	Mon Nov 12 19:04:49 2001
+++ /home/usuaris/toni/nucli_report/Configure.help-ca	Mon Nov 12 19:21:56 2001
@@ -19,6 +19,8 @@
 #     <http://home.elka.pw.edu.pl/~dmierzej/linux/kernel/>
 #   - German, by SuSE, at <http://www.suse.de/~ke/kernel>. This patch
 #     also includes infrastructure to support different languages.
+#   - Catalan, by Antoni Bella (bella5@teleline.es), at
+#     http://www.terra.es/personal7/bella5/traduccions.htm
 #
 # To access a document on the WWW, you need to have a direct Internet
 # connection and a browser program such as netscape or lynx. If you
@@ -893,7 +895,7 @@
 
   It is normally safe to answer Y; however, the default is N.
 
- -ATA Work(s) In Progress (EXPERIMENTAL)
+ATA Work(s) In Progress (EXPERIMENTAL)
 CONFIG_IDEDMA_PCI_WIP
   If you enable this you will be able to use and test highly
   developmental projects. If you say N, the configurator will
@@ -4686,7 +4688,7 @@
   drive, PLIP link (Parallel Line Internet Protocol is mainly used to
   create a mini network by connecting the parallel ports of two local
   machines) etc., then you need to say Y here; please read
- -  <file:Documentation/parport.txt> and drivers/parport/BUGS-parport.
+  <file:Documentation/parport.txt> and <drivers/parport/BUGS-parport>.
 
   For extensive information about drivers for many devices attaching
   to the parallel port see <http://www.torque.net/linux-pp.html> on
@@ -6189,7 +6191,7 @@
   control memory (128K-1KVC, 512K-4KVC), the size of the packet
   memory (128K, 512K, 1M), and the PHY type (Single/Multi mode OC3,
   UTP155, UTP25, DS3 and E3). Go to:
- -  	www.iphase.com/products/ClassSheet.cfm?ClassID=ATM
+  	<http://www.iphase.com/products/ClassSheet.cfm?ClassID=ATM>
   for more info about the cards. Say Y (or M to compile as a module
   named iphase.o) here if you have one of these cards.
 
@@ -6905,10 +6907,10 @@
   This is support for BusLogic MultiMaster and FlashPoint SCSI Host
   Adapters. Consult the SCSI-HOWTO, available from
   <http://www.linuxdoc.org/docs.html#howto>, and the files
- -  README.BusLogic and README.FlashPoint in drivers/scsi for more
- -  information. If this driver does not work correctly without
- -  modification, please contact the author, Leonard N. Zubkoff, by
- -  email to lnz@dandelion.com.
+  <file:drivers/scsi/README.BusLogic> and
+  <file:drivers/scsi/README.FlashPoint> for more information. If this
+  driver does not work correctly without modification, please contact
+  the author, Leonard N. Zubkoff, by email to lnz@dandelion.com.
 
   You can also build this driver as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
@@ -7150,7 +7152,7 @@
   If your system has problems using this new major version of the
   SYM53C8XX driver, you may switch back to driver version 1.
 
- -  Please read drivers/scsi/sym53c8xx_2/Documentation.txt for more
+  Please read <file:drivers/scsi/sym53c8xx_2/Documentation.txt> for more
   information.
 
 PCI DMA addressing mode
@@ -7803,7 +7805,8 @@
  
   This is a driver for RAID/SCSI Disk Array Controllers (EISA/ISA/PCI) 
   manufactured by Intel/ICP vortex (an Intel Company). It is documented
- -  in the kernel source in drivers/scsi/gdth.c and drivers/scsi/gdth.h. 
+  in the kernel source in <file:drivers/scsi/gdth.c> and
+  <file:drivers/scsi/gdth.h.>
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
@@ -9763,7 +9766,7 @@
 Cyclom 2X(tm) multiprotocol cards
 CONFIG_CYCLADES_SYNC
   Cyclom 2X from Cyclades Corporation (<http://www.cyclades.com> and
- -  <http://www.cyclades.com.br)> is an intelligent multiprotocol WAN
+  <http://www.cyclades.com.br>) is an intelligent multiprotocol WAN
   adapter with data transfer rates up to 512 Kbps. These cards support
   the X.25 and SNA related protocols. If you have one or more of these
   cards, say Y to this option. The next questions will ask you about
@@ -10607,7 +10610,7 @@
   module, say M here and read <file:Documentation/modules.txt> as well
   as <file:Documentation/networking/net-modules.txt>.
 
- -EtherExpressPro support/EtherExpress 10 (i82595) support
+EtherExpressPro and EtherExpress 10 (i82595) support
 CONFIG_EEXPRESS_PRO
   If you have a network (Ethernet) card of this type, say Y. This
   driver supports intel i82595{FX,TX} based boards. Note however
@@ -12545,7 +12548,7 @@
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
   The module will be called aiptek.o. If you want to compile it as a
- -  module, say M here and read Documentation/modules.txt.
+  module, say M here and read <file:Documentation/modules.txt>.
 
 Use input layer for ADB devices
 CONFIG_INPUT_ADBHID
@@ -13542,7 +13545,7 @@
 CONFIG_USB_BLUETOOTH
   Say Y here if you want to connect a USB Bluetooth device to your
   computer's USB port. You will need the Bluetooth stack (available
- -  at <http://developer.axis.com/software/index.shtml)> to fully use
+  at <http://developer.axis.com/software/index.shtml>) to fully use
   the device.
 
   This code is also available as a module ( = code which can be



- -- 
- --

   Sort

######## Antoni Bella Perez ####################                             |
# [Pàgina de traduccions del nucli Linux]                    |
# http://www.terra.es/personal7/bella5/traduccions.htm
# [Traduciones al catalan del Nucleo Linux]                |
## <bella5@teleline.es> ## i
col·laborador del projecte Debian en català: debian.org/index.ca.htm
Maquinari: - Pentium II 300MHz 128MB memòria 599.65 bogomips
Sistema:   - Debian GNU/Linux-2.4.15-pre2  -  XFree86 4.1.0-9

- -
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE78BYXGfXdVUGHvegRAv8PAJ9OvhPbvzlu5Aae+vqsnl6iY/z2mQCdE5XA
FjgRPzRlcuxQdFVTGktnRm8=
=6R2g
-----END PGP SIGNATURE-----
