Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264518AbSIVUbK>; Sun, 22 Sep 2002 16:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264520AbSIVUbK>; Sun, 22 Sep 2002 16:31:10 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:48603 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264518AbSIVUbH> convert rfc822-to-8bit; Sun, 22 Sep 2002 16:31:07 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: wolk-devel@lists.sourceforge.net, wolk-announce@lists.sourceforge.net
Subject: [ANNOUNCE] WOLK v3.6 FINAL
Date: Sun, 22 Sep 2002 22:35:41 +0200
X-Mailer: KMail [version 1.4]
Organization: WOLK - Working Overloaded Linux Kernel
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209222235.29618.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

this is v3.6 FINAL of WOLK. This is the last release of the 3.x series!


Here we go, Changelog from v3.5 -> v3.6
---------------------------------------

 o indicates work by WOLK Developers (almost me)
 + indicates work by WOLK Users

+   add:        SuperPage Support for alpha, sparc64 and x86
                 This is an EXPERIMENTAL PATCH. Apply manually! Nr. 990

o   add:        SCSI-Idle for v2.4.19 + SCSI Idle Daemon in WOLK-Tools package

o   add:        oom_killer updates from v2.4.19 final

o   add:        some another ext3 additions from v2.4.20-pre5

o   add:        VFS Soft/Hard-Limit of FileDescriptors

o   add:        ebtables v2.0

+   fixed:      USB v2.4.19 compile problems / missing definitions

+   fixed:      BlueTooth v2.4.19 compile problems / missing definitions

+   fixed:      Some Config dependencies for ISDN / USB Stuff

o   fixed:      LSM compile problems. totally conflicts with CTX(vserver)

o   fixed:      One AIO reversed #ifdef -> #ifndef

o   fixed:      Forgot to add "gr_is_capable(cap)" to #ifndef CONFIG_LSM
                 This broke capabilities to add/remove with grsecurity!

o   update:     MIPL Mobile IPv6 v0.9.4

o   update:     Bridge with Netfilter firewalling v0.0.7

o   update:     ACPI (Sep 18th, 2002) (use pci=noacpi when you have problems)

o   update:     e2compression v0.4.43

o   update:     SOFFIC (Secure On-the-Fly File Integrity Checker) v0.1

o   update:     Crypto v2.4.19-1
                 includes new options:
                 - 3DES cipher (64bit blocksize)
                 - GOST cipher (64bit blocksize)
                 - NULL cipher (NO CRYPTO)
                 - RIPEMD160 digest
                 - SHA256 digest
                 - SHA384 digest
                 - SHA512 digest
                 - Atomic Loop Crypto
                 - Loop IV hack
                 - Loop Crypto Debugging
                 - IPSEC tunneling (ipsec_tunnel) support

o   update:     Compressed Cache v0.24-pre4
                 
o   update:     HTB v3.6-020525
                 
o   update:     grsecurity v1.9.7 final
                 + gradm v1.5 final in the WOLK-tools package
                 
o   update:     IBM's NGPT2 (Next Generation Posix Threading 2) v2.0.2
                 
o   update:     htree ext3 directory indexing 2.4.19-3-dxdir
                 
o   update:     UML - User-Mode-Linux v2.4.18-53

o   update:     NTFS Filesystem Driver v2.1.0a

o   update:     XFree v4.2.0 DRM/DRI Drivers from 2.4.20-preX-acX tree
                 
o   update:     JFS v1.0.22

o   update:     Intel EtherExpress PRO/100 Support (Alternate Driver) v2.1.6
                 
o   update:     Intel EtherExpress PRO/1000 Gigabit NIC Support v4.3.2

o   update:     i810/i815 Framebuffer Device Driver v0.0.33
                 
o   change:     CTX12 (Virtual private servers and security contexts)
                 and disable vservers if grsecurity is selected (breaks gradm)

o   removed:    some ext3 additions
                 (causes system locking at high disk i/o)



Release Info:
-------------
Date   : 22th September, 2002
Time   : 11:45 pm CET
URL    : http://sf.net/projects/wolk


md5sums:
--------
abbb41870e7f2d68894ad254ee04379c *linux-2.4.18-wolk3.5-to-3.6.patch.bz2
31a52bd394478c023103331909e86c6d *linux-2.4.18-wolk3.5-to-3.6.patch.gz
4325558fed5d3d34ead1f0e701dfb576 *linux-2.4.18-wolk3.6-fullkernel.tar.bz2
2f79315cf6977b749f0e3be3742d218b *linux-2.4.18-wolk3.6-fullkernel.tar.gz
2e84031f07a0958a2de8e71276cb4552 *linux-2.4.18-wolk3.6-patch.patch.bz2
61178792c7eb21e01bebf60535caf244 *linux-2.4.18-wolk3.6-patch.patch.gz
2efd7753fc31a86fa39b87df38fc78c7 *linux-2.4.18-wolk3.6-patchset.tar.bz2
b12c6147b97b03bb34ff4bc9a8f27d31 *linux-2.4.18-wolk3.6-patchset.tar.gz


Have fun!

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


