Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUCOLbf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 06:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbUCOLbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 06:31:35 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:2313 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261943AbUCOLba convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 06:31:30 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: lkml <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] WOLK v2.0 for Kernel v2.6.4
Date: Sun, 14 Mar 2004 23:14:32 +0100
User-Agent: KMail/1.6.1
Cc: wolk-devel@lists.sourceforge.net, wolk-announce@lists.sourceforge.net
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403142314.37398@WOLK>
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

2nd WOLK version for 2.6. Apply ontop of a vanilla 2.6.4 from kernel.org.

Tell me what you think, how it works, what I've missed, what should go in bla
bla you know what I mean ;)

Have fun :)


BIG NOTE:
- ---------
I haven't merged grsecurity v2 nor Win4Lin into mainstream WOLK for 2.6. 
Currently, I won't break users of 4g/4g, 4k stacks nor uml-skas3, currently a 
no-go with grsecurity. Win4Lin is Desktop Usage, so if you want that, apply 
it manually. Both patches are located in the patch itself in 
the ./ADDON-patches directory after applying the main patch. Apply as usual.




Changelog from v2.6.3-wolk1.0 -> v2.6.4-wolk2.0
- -----------------------------------------------
              merged with 2.6.4 final				(Linus Torvalds)
              merged with 2.6.4-mm1				(Andrew Morton)

o   ADDON:    grsecurity v2.0 for 2.6.4				(Brad Spengler)
o   ADDON:    Win4Lin v5.0 support				(Netraverse)

o   added:    IP stealth mode					(Sean Trifero)
o   added:    IP nmap freak					(Jaguar)
o   added:    IBM ASM Service Processor Device Driver		(IBM Corporation)
o   added:    Microsoft encryption/compression (MPPE/MPPC) 0.99	(Jan Dubiec)
o   added:    ACPI: Read DSDT from initrd			(Markus Gaugusch)
o   added:    Emulex LP fibre channel adapter cards v2.10a	(Emulex)
o   added:    Application Layer 7 Netfilter v0.6		(Ethan Sommer)
o   added:    Application Layer 7 Netfilter Childlevel v1.0	(Ethan Sommer)
o   added:    "reallyquiet" boot option to shut up all console	(me)
                log level output
o   added:    Allow protocol 254				(Paul Mackerras/Omkhar)
o   added:    Balance IRQs more readily				(Adam Litke)
o   added:    IMQ Target / Device support			(Marcel Sebek)
o   added:    PSCHED_CLOCK_SOURCE is PSCHED_CPU if TSC		(me)
o   added:    Allow reading last block (write not)		(Andrea Arcangeli)
o   added:    LUFS v0.97					(Florin Malita)
o   added:    shfs v0.32					(Miroslav Spousta)
o   added:    CDfs v2.6.3					(Michiel Ronsse)
o   added:    PRAMfs v1.0.2 					(Steve Longerbeam)
o   added:    JFS DMAPI (XDSM) support v1.0			(IBM Corporation)
o   added:    Infiniband support				(Topspin Comm.)
o   added:    most of 2.6-tiny tree				(Matt Mackall)
o   added:    NFS ACL protocol extension			(SuSE GmbH)
o   added:    KDB v4.3						(Keith Owens)
o   added:    Event Logging support (evlog) v2.6.0		(IBM Corporation)
o   added:    UML skas-3					(Jeff Dike)
o   added:    kernel statd implementation			(Olaf Kirch)
o   added:    Hauppauge WinTv PVR 250/350 boards 0.1.8 support	(Steven Fuerst)
o   added:    BSD accounting-6					(Tim Schmielau)
o   added:    TuX v3-2.6.3-B4					(Ingo Molnar)
o   added:    Allow/Disallow net devices to contribute to the	(Robert Love)
                kernel entropy pool (aka netdev-random).
o   added:    IPv6 Mobility (MIPv6) support			(IBM Corporation)
o   added:    Bind mount Extensions (BME) v0.03			(Herbert Poetzel)
o   added:    Broadcom BCM4400 v3.0.7				(Broadcom Corporation)
o   added:    ReiserFS v3: quota support			(Chris Mason)
o   added:    ReiserFS v3: support for nested transactions	(Chris Mason)
o   added:    ReiserFS v3: data=ordered support, along with	(Chris Mason)
                a journal header attached to the buffer head.
o   fixed:    ReiserFS v3: lowers reiserfs latencies by adding	(Chris Mason)
                 conditional schedules
o   fixed:    ReiserFS v3: bug where a change in tree height	(Chris Mason)
                might not be detected
o   fixed:    ReiserFS v3: data corruption bug			(Chris Mason)
o   fixed:    ReiserFS v3: removed old stale debugging code	(Chris Mason)
o   fixed:    ReiserFS v3: logging speedups for small		(Chris Mason)
                transactions and fsync heavy applications
o   fixed:    HugePages works now				(no one)
o   fixed:    ide-cd DMA audio ripping				(Jens Axboe)
                (before it was: slow, now it is: hyper fast)
o   fixed:    typo in fs/ext3/acl.c				(me)
o   fixed:    cleanup include/linux/sysctl.h unreadability	(me)
o   fixed:    Twofish: loop_func_table->transfer changed	(Andrea Arcangeli)
o   updated:  Qlogic QLA2xxx v8.00.00b11			(Qlogic Corporation)
o   updated:  XFS CVS-2004-03-08_06:00_UTC			(SGI)
o   updated:  Broadcom BCM5700 driver v7.2.15			(Broadcom Corporation)
o   updated:  Compaq SMART2 Driver v2.6.0			(Compaq) 
o   updated:  ReiserFS v3 extended attributes			(SuSE GmbH)
o   updated:  ReiserFS v3 POSIX Access Control Lists		(SuSE GmbH)
o   updated:  ReiserFS v3 Security Labels			(SuSE GmbH)
o   updated:  Bootsplash v3.1.4					(SuSE GmbH)   
o   updated:  dmesg cleanup					(me)
o   updated:  CFQ I/O scheduler with ionice support		(Jens Axboe)
                - ionice.c in ./userspace-programs		(Jens Axboe)  
o   updated:  autoregulate swappiness v9			(Con Colivas)
o   removed:  ReiserFS v4					(Namesys)   
                - far away from near production ready
o   changed:  Lower timeout values for IPv4 Netfilter code	(me)
o   changed:  I like /proc/config.gz only for root		(me)




Todo
- ----
o  Linux Trustees
o  menu cleanups
o  DRBD once it's ported to 2.6
o  vservers for 2.6 once Herbert comes up with a patch
o  _____ <add more things if you want>


md5sums:
- --------
d854d329066893200ca89e24ff5b45d7  linux-2.6.4-wolk2.0.patch.bz2
a89f6c372a33be0d7f9b749a60373b27  linux-2.6.4-wolk2.0.patch.gz


- --
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint:  3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at http://pgp.mit.edu. Encrypted e-mail preferred
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAVNlMVp3i49tEGhYRAnGBAKDljnpeQjNxuGhlSRWQBqqOWVsO9gCgxoJN
DhTWmE7YGECw6G0nDQH0+V0=
=HyOg
-----END PGP SIGNATURE-----
