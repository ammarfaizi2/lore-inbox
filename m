Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264972AbSJ3X5b>; Wed, 30 Oct 2002 18:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264978AbSJ3X5a>; Wed, 30 Oct 2002 18:57:30 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:26256 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264972AbSJ3Xzz> convert rfc822-to-8bit; Wed, 30 Oct 2002 18:55:55 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: wolk-devel@lists.sourceforge.net, wolk-announce@lists.sourceforge.net
Subject: [ANNOUNCE] v2.2.22-2-secure // [PATCH | PATCHSET | FULLKERNEL]
Date: Thu, 31 Oct 2002 00:58:43 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210310057.24743.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I am proud to announce v2.2.22-2-secure. The well known -secure tree by me.
This release is almost a bugfixing release but also with some nice new 
features like HTB3, QoS Backport from 2.4 etc. - See below. :-)

Since I do this kernel we've upgraded all our servers of our customers at my 
company to this tree without any major or minor problems.
The servers vary from just beeing a mailserver for 5 workstations to highend 
servers for ~ 3000 users beeing proxy-, smtp-, pop3-/imap-, file-, web-, 
firewall-server and ipsec gate.


-> The intended purpose is for production/servers/firewalls <-


 o indicates work by me
 + indicates work by users

Changes in 2.2.22-2-secure
--------------------------
o   add:        ALi 5451 gameport support
o   add:        QoS Backport from Linux v2.4.19 to v2.2.21
o   add:        rbtree 2.2.21-1
o   add:        HTB3.7 backported from 2.4.20pre11 to DS-9 on 2.2.21
o   add:        skb_realloc_headroom() panics when new headroom
                is smaller than existing headroom.
+   fixed:      aic7xxx (new) as a module
+   fixed:      DEC Tsunami I2C interface just for ALPHA arch
+   fixed:      compile af_packet (CONFIG_PACKET) as a module
o   fixed:      compile error if some MASQ settings are not set
o   fixed:      compile error if ext3fs was not selected
o   update:     802.1d Ethernet Bridging v1.03
o   update:     Firewall for the ethernet bridge, using ipchains, v1.03
o   update:     Stealth Networking v2.2.22
o   update:     Openwall v2.2.22-ow1
o   update:     HAP for Openwall v2.2.22-ow1
o   update:     "Super" FreeS/WAN 1.98b includes:
                 X.509 0.9.14, Notify/Delete SA,
                 NAT Traversal 0.3 and ALG 0.8
o   update:     i2c v2.6.6-cvs-2002-10-23
o   update:     lmsensors v2.6.6-cvs-2002-10-23
o   change:     Network Devices reordered near to Networking Options


Changes in v2.2.22-1-secure
---------------------------
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


Changes in 2.2.21-3-secure
--------------------------
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
Date   : October, 31th, 2002
Time   : 01:00 am CET
URL    : http://sf.net/projects/wolk


md5sums:
--------
05db2c6743f7f1d62a44d690933e2f82 
*linux-2.2.22-1-secure-to-2.2.22-2-secure.patch.bz2
24c28e9786eb03d3b88388fb42d1cf16 
*linux-2.2.22-1-secure-to-2.2.22-2-secure.patch.gz
8a8b41286ab663923c1d576b982e73ab *linux-2.2.22-2-secure-fullkernel.tar.bz2
1c6e2fb974a953904faf34e5f6fbea3e *linux-2.2.22-2-secure-fullkernel.tar.gz
3e9ef836ddb1e8638762a13e7f5c80e0 *linux-2.2.22-2-secure-patchset.tar.bz2
19469742ea059658720aa48f0d9e3b72 *linux-2.2.22-2-secure-patchset.tar.gz
48b836108b9cce6b288b01615ff100be *linux-2.2.22-2-secure.patch.bz2
3890789a9b017bde8b6e29bbaa829320 *linux-2.2.22-2-secure.patch.gz
d41d8cd98f00b204e9800998ecf8427e *md5sums-2.2.22-2-secure


URL:
----
http://prdownloads.sf.net/wolk/linux-2.2.22-1-secure-to-2.2.22-2-secure.patch.bz2?download
http://prdownloads.sf.net/wolk/linux-2.2.22-1-secure-to-2.2.22-2-secure.patch.gz?download
http://prdownloads.sf.net/wolk/linux-2.2.22-2-secure-fullkernel.tar.bz2?download
http://prdownloads.sf.net/wolk/linux-2.2.22-2-secure-fullkernel.tar.gz?download
http://prdownloads.sf.net/wolk/linux-2.2.22-2-secure-patchset.tar.bz2?download
http://prdownloads.sf.net/wolk/linux-2.2.22-2-secure-patchset.tar.gz?download
http://prdownloads.sf.net/wolk/linux-2.2.22-2-secure.patch.bz2?download
http://prdownloads.sf.net/wolk/linux-2.2.22-2-secure.patch.gz?download


Thanks goes out to all the great developers who made this possible !!

Feedback welcome :) ... Have fun!


-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


