Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbUCXTeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 14:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbUCXTeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 14:34:46 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:33292 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263798AbUCXTei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 14:34:38 -0500
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
To: lkml <linux-kernel@vger.kernel.org>
Date: Wed, 24 Mar 2004 20:32:37 +0100
User-Agent: KMail/1.6.1
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Organization: Linux-Systeme GmbH
Message-Id: <200403242032.38265@WOLK>
Subject: Linux 2.2.27-pre1 released
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

now some more fixes with 2.2.27-pre1. Please test. Have fun :)



2.2.27-pre1
- -----------
o	fixed TCP keepalive bug					(Neal Cardwell)
o       fixed tcp seq nr wrapping bug				(Ulrik De Bie)
o	added cciss root translation table			(Eduard Bloch)
o	VIA KL133/KM133 northbridge: vga console going crazy	(Roberto Biancardi)
o	speedup 'make dep'					(Benoit Poulot-Cazajous)
o	disabled MCE only on Pentiums by default (2.4 backport)	(Herbert Xu)
	  (boot with 'mce' if your MCE works as expected)
o	skb_realloc_headroom() panics when new headroom is	(James Morris)
	  smaller than existing headroom
o	invalid nh.raw use after free				(Julian Anastasov)
o	fix a local APIC initaliziation ordering bug that	(Andrea Arcangeli)
	  triggers on the P4
o	TSC calibration must be dynamic and not a compile	(Andrea Arcangeli)
	  time thing because gettimeofday is dynamic and it
	  depends on the TSCs to be in sync
o	fix deadlock on shutdown in 8139too			(Herbert Xu)
o	support for ELF executables which use an a.out format	(Solar Designer)
	  interpreter (dynamic linker) moved into a separate
	  configuration option and disabled by default
o	fixed sys_utimes perm check according to sys_utim	(Al Viro)
o	show us the saved kernel command line (2.4 backport)	(me)
o	some whitespace cleanups, some coding style cleanups	(me)
o	fixed some gcc warnings					(me)
o	add PCI ID for 82820 NIC to eepro100 network driver	(me)
o	move 'Network device support' near 'Networking options'	(me)




- --
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint:  3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at http://pgp.mit.edu. Encrypted e-mail preferred
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: !! No Risk - No Fun !! - Try to crack this ;-)

iD8DBQFAYeJVVp3i49tEGhYRAuHmAKD2ihPakphQJTuVAuxlue4OyIOMjQCgoS8h
0stEf8UFmhkHcPYfftNGeO0=
=BpqA
-----END PGP SIGNATURE-----
