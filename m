Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbUJ0VRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbUJ0VRg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUJ0VIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:08:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38924 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262726AbUJ0Uzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:55:49 -0400
Date: Wed, 27 Oct 2004 22:55:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill old PCI changelog
Message-ID: <20041027205512.GD2713@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

There's not much value in shipping a changelog who's last update was 
five years ago.

diffstat output:
 arch/i386/pci/changelog |   62 ----------------------------------------
 1 files changed, 62 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/arch/i386/pci/changelog	2004-10-18 23:55:06.000000000 +0200
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,62 +0,0 @@
- -/*
- - * CHANGELOG :
- - * Jun 17, 1994 : Modified to accommodate the broken pre-PCI BIOS SPECIFICATION
- - *	Revision 2.0 present on <thys@dennis.ee.up.ac.za>'s ASUS mainboard.
- - *
- - * Jan 5,  1995 : Modified to probe PCI hardware at boot time by Frederic
- - *     Potter, potter@cao-vlsi.ibp.fr
- - *
- - * Jan 10, 1995 : Modified to store the information about configured pci
- - *      devices into a list, which can be accessed via /proc/pci by
- - *      Curtis Varner, cvarner@cs.ucr.edu
- - *
- - * Jan 12, 1995 : CPU-PCI bridge optimization support by Frederic Potter.
- - *	Alpha version. Intel & UMC chipset support only.
- - *
- - * Apr 16, 1995 : Source merge with the DEC Alpha PCI support. Most of the code
- - *	moved to drivers/pci/pci.c.
- - *
- - * Dec 7, 1996  : Added support for direct configuration access of boards
- - *      with Intel compatible access schemes (tsbogend@alpha.franken.de)
- - *
- - * Feb 3, 1997  : Set internal functions to static, save/restore flags
- - *	avoid dead locks reading broken PCI BIOS, werner@suse.de 
- - *
- - * Apr 26, 1997 : Fixed case when there is BIOS32, but not PCI BIOS
- - *	(mj@atrey.karlin.mff.cuni.cz)
- - *
- - * May 7,  1997 : Added some missing cli()'s. [mj]
- - * 
- - * Jun 20, 1997 : Corrected problems in "conf1" type accesses.
- - *      (paubert@iram.es)
- - *
- - * Aug 2,  1997 : Split to PCI BIOS handling and direct PCI access parts
- - *	and cleaned it up...     Martin Mares <mj@atrey.karlin.mff.cuni.cz>
- - *
- - * Feb 6,  1998 : No longer using BIOS to find devices and device classes. [mj]
- - *
- - * May 1,  1998 : Support for peer host bridges. [mj]
- - *
- - * Jun 19, 1998 : Changed to use spinlocks, so that PCI configuration space
- - *	can be accessed from interrupts even on SMP systems. [mj]
- - *
- - * August  1998 : Better support for peer host bridges and more paranoid
- - *	checks for direct hardware access. Ugh, this file starts to look as
- - *	a large gallery of common hardware bug workarounds (watch the comments)
- - *	-- the PCI specs themselves are sane, but most implementors should be
- - *	hit hard with \hammer scaled \magstep5. [mj]
- - *
- - * Jan 23, 1999 : More improvements to peer host bridge logic. i450NX fixup. [mj]
- - *
- - * Feb 8,  1999 : Added UM8886BF I/O address fixup. [mj]
- - *
- - * August  1999 : New resource management and configuration access stuff. [mj]
- - *
- - * Sep 19, 1999 : Use PCI IRQ routing tables for detection of peer host bridges.
- - *		  Based on ideas by Chris Frantz and David Hinds. [mj]
- - *
- - * Sep 28, 1999 : Handle unreported/unassigned IRQs. Thanks to Shuu Yamaguchi
- - *		  for a lot of patience during testing. [mj]
- - *
- - * Oct  8, 1999 : Split to pci-i386.c, pci-pc.c and pci-visws.c. [mj]
- - */
\ No newline at end of file



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgAswmfzqmE8StAARAtMyAJ4+cKLyitL0by8XQlDRdcy9KGw/5QCffy88
JTyxEpMwlSsRSW6xZ26XBbY=
=1ny4
-----END PGP SIGNATURE-----
