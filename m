Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265832AbSIRI06>; Wed, 18 Sep 2002 04:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265851AbSIRI06>; Wed, 18 Sep 2002 04:26:58 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:64428 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265832AbSIRI0y> convert rfc822-to-8bit; Wed, 18 Sep 2002 04:26:54 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] v2.2.22-1-secure // [PATCH | PATCHSET | FULLKERNEL]
Date: Wed, 18 Sep 2002 10:31:18 +0200
X-Mailer: KMail [version 1.4]
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209181027.22196.m.c.p@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I am proud to announce v2.2.22-1-secure. The well known -secure tree by me,
updated to the latest stable 2.2 kernel release, v2.2.22, released by Alan
Cox yesterday.

Since I do this kernel we've upgraded all our servers of our customers at my 
company to this tree without any major or minor problems.
The servers vary from just beeing a mailserver for 5 workstations to highend 
servers for ~ 3000 users beeing proxy-, smtp-, pop3-/imap-, file-, web-, 
firewall-server and ipsec gate.


-> The intended purpose is for production/servers/firewalls <-


 o indicates work by me
 + indicates work by users


Changes in v2.2.22-1-secure:
----------------------------
o  add:      Port/Socket Pseudo ACLs v2.2.21-14
o  add:      VM buffer tuning
o  add:      Etherdivert
o  add:      802.1d Ethernet Bridging v1.02
o  add:      Firewall for the ethernet bridge, using ipchains v1.02
o  add:      IPsec masquerading with IPVS
o  add:      Compiler optimizations for new subarches
+  add:      UserIP Accounting v0.9c-rc1
o  update:   Openwall v2.2.21-ow2
o  update:   HAP for Openwall v2.2.21-ow2
o  update:   i2c v2.6.4
o  update:   lm-sensors v2.6.4
o  update:   Tekram DC395 SCSI Controller Driver v1.41
o  update:   FreeS/WAN v1.97 + x.509 v0.9.12


Changes in 2.2.21-3-secure:
---------------------------
o   add:     i2c v2.6.3
o   add:     lm-sensors v2.6.3
+   re-add:  ReiserFS v3.5.35
+   add:     ReiserFS v3.5.35 and ext3 v0.07a Coexistence Fix


Changes in 2.2.21-2-secure
--------------------------

o   add:     IDE Backport from 2.4.x (IDE-Ole) v2.2.21.05202002
o   add:     IP Virtual Server v1.08 for 2.2 Kernels
o   add:     Tekram DC395 SCSI Controller Driver v1.40
o   update:  Openwall and HAP to its newest Version
o   removed: New IDE from Andre Hedrick in favor of IDE-Ole
o   removed: ReiserFS Code


Changes in 2.2.21-1-secure
--------------------------
- Initial Release

o   add:     Openwall v2.2.20-ow1
o   add:     HAP for Openwall v2.2.20-ow1
o   add:     Stealth Networking
o   add:     RAID v2.2.20-raid 4 (Autodetect, Boot support (l/s) etc.
o   add:     Ext3 Filesystem Support v0.07a
o   add:     ReiserFS v3.5.35
o   add:     IFF Dynamic Patch
o   add:     PPPoE
o   add:     CryptoAPI (Kerneli) v2.2.18-3
o   add:     CIPE (Crypto IP Encapsulation)
o   add:     Extended Attributes and ACL for ext2 (EA v0.8.26/ACL v0.8.27)
o   add:     Some NIC Drivers:
                - COMPEX-RL100a / Winbond-W89c840 PCI Ethernet
                - Myson MTD803 PCI Ethernet
                - National Semiconductor DP8381x series PCI Ethernet
                - National Semiconductor DP8382x series PCI Ethernet
                - Sundance ST201 "Alta" PCI Ethernet
o   add:     Adaptec AIC7xxx v6.2.4 Driver
o   add:     Most Patches of the AA-Kernel v2.2.21pre2aa2 tree
o   add:     MPPE v0.9.5
o   add:     BIGMEM (highmem) to allocate Memory >1GB
o   add:     USAGI v20020513-2.2.20
o   add:     BadRAM / BadMEM v2.2.19B
o   add:     FreeS/WAN v1.97
o   add:     New IDE from Andre Hedrick



Release Info:
-------------
Date   : 17th September, 2002
Time   : 02:45 am CET
URL    : http://sf.net/projects/wolk


md5sums:
--------
785bffedf1a5eefc2ded3393ae12ec0d  
linux-2.2.21-3-secure-to-2.2.22-1-secure.patch.bz2
d8aa7347f27d572bedcee5bbd73cc6bf  
linux-2.2.21-3-secure-to-2.2.22-1-secure.patch.gz
8aabadc5fad3674f582f3c958840c6e4  linux-2.2.22-1-secure-fullkernel.tar.bz2
de97637ef79eb1160696e881bb21821c  linux-2.2.22-1-secure-fullkernel.tar.gz
185fbaf768c1bc05a168f9e8ca2b920f  linux-2.2.22-1-secure-patchset.tar.bz2
b585ea71d220e37240d818bc47ed1972  linux-2.2.22-1-secure-patchset.tar.gz
44a562b7f33b4df93fdd880a7f6af721  linux-2.2.22-1-secure.patch.bz2
6740cabcf4b1a47b51b96431cd442372  linux-2.2.22-1-secure.patch.gz


URL:
----
http://prdownloads.sf.net/wolk/linux-2.2.21-3-secure-to-2.2.22-1-secure.patch.bz2?download
http://prdownloads.sf.net/wolk/linux-2.2.21-3-secure-to-2.2.22-1-secure.patch.gz?download
http://prdownloads.sf.net/wolk/linux-2.2.22-1-secure-fullkernel.tar.bz2?download
http://prdownloads.sf.net/wolk/linux-2.2.22-1-secure-fullkernel.tar.gz?download
http://prdownloads.sf.net/wolk/linux-2.2.22-1-secure-patchset.tar.bz2?download
http://prdownloads.sf.net/wolk/linux-2.2.22-1-secure-patchset.tar.gz?download
http://prdownloads.sf.net/wolk/linux-2.2.22-1-secure.patch.bz2?download
http://prdownloads.sf.net/wolk/linux-2.2.22-1-secure.patch.gz?download


Thanks goes out to all the great developers who made this possible !!

Feedback welcome :) ... Have fun!



-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


