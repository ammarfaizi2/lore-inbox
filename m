Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265266AbSJWWOc>; Wed, 23 Oct 2002 18:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265265AbSJWWOa>; Wed, 23 Oct 2002 18:14:30 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:30351 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265263AbSJWWOX> convert rfc822-to-8bit; Wed, 23 Oct 2002 18:14:23 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: wolk-devel@lists.sourceforge.net, wolk-announce@lists.sourceforge.net
Subject: [ANNOUNCE] WOLK v3.7 FINAL // [PATCH | PATCHSET | FULLKERNEL]
Date: Thu, 24 Oct 2002 00:19:55 +0200
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210240019.55188.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

last release for 3.x series of WOLK. Development stopped until 2.4.20/2.4.21 
and WOLK 4.


Changelog from v3.6 -> v3.7
---------------------------
o   add:      o(1) Scheduler 2.4.19-rml-1 + fixes 
o   add:      RCU Poll from latest -aa kernel tree
o   add:      Poll/Select Fastpath 
o   add:      Low Latency 2.4.19 + fixes
o   add:      SMP-timers
o   add:      Allow console switch after kernel panic
o   add:      panic() LED+Speaker Morse Code + unblank console if panic()
o   add:      Ext3 O_DIRECT 
o   add:      Ext3 Documentation in filesystems/ext3.txt
o   add:      ATI Rage 128 Pro (aty128fb) acceleration fix
o   add:      IBM ThinkPad laptop support v3.70
+   add:      USB: some flags added, needed by the Genesys USB-Controller
o   add:      Oracle Cluster File System (OCFS)
o   add:      TCP Stealth
o   add:      O_STREAMING file I/O flag
o   add:      Log-Level via Sysrq()
o   add:      IPVS: Allow forwarding of packets with local source address
o   add:      XBOX: gamepad v0.0.6 & gamepad mousedriver v0.0.2
o   add:      CIFS v0.5.0
o   add:      AFS distributed file system support
o   add:      Adaptec AIC79xx support
o   add:      Creative SBLive! Audigy support
o   add:      USB LCD driver support
+   add:      More Framebuffer Boot Logos
o   add:      __alloc_page failed detection + kernel option
o   add:      Cardbus "PowerUp correctly" hack + kernel option
o   fixed:    unresolved symbols in hid.o: hiddev_hid_event 
o   fixed:    Add the "everytime missing" JFS statistics config option
+   fixed:    ipt_realm build fails if "CONFIG_NET_CLS_ROUTE4" is not set
o   fixed:    miroSOUND PCM20 radio: now only if CONFIG_SOUND_ACI_MIXER
o   fixed:    userspace tool asmem now works again
o   fixed:    new procps (3.x.x) now also works with WOLK 
o   fixed:    /dev/kmem is again accessable if grsecurity is off
o   fixed:    tcp_v4_lookup_listener was exported twice
o   fixed:    SMP build-problems (missed some APIC and LowLat stuff)
o   fixed:    ext3 htree build/linking problem
o   fixed:    ext2 compression (e2compr) build problem
o   fixed:    cryptoloop.c: 'loop_iv_t' previously declared here
o   fixed:    unix.o: unresolved symbols: gr_handle_create/gr_check_create
o   fixed:    HTB Configure.help entry missed while updating to HTB3.6
o   fixed:    FINALLY: the unresolved symbols for midi/synth stuff with ALSA 
o   fixed:    irda-usb: irda-usb.c compile error
o   fixed:    HID (full support) compile error
o   fixed:    zftape: zftape-init.c compile error
o   update:   Bonding fixes found in 2.4.19 and pending fix for 2.4.20-pre11
o   update:   PPP and PPPoE updates from 2.4.19 and 2.4.20-pre10
o   update:   MPPE/MPPC v0.94
o   update:   "Super" FreeS/WAN 1.98b includes:
                X.509 0.9.15, Notify/Delete SA,
                NAT Traversal 0.3 and ALG 0.8
o   update:   ACPI (Oct 2nd, 2002)
o   update:   i2c v2.6.6-cvs-2002-10-23
o   update:   lmsensors v2.6.6-cvs-2002-10-23
o   update:   XFS + KDB v2.4.19 CVS snapshot (2002-09-13)
o   update:   SOFFIC (Secure On-the-Fly File Integrity Checker) v0.2p1
               + CryptoAPI dependencies
o   update:   ReiserFS Updates pending for 2.4.19/2.4.20 + speedups
o   update:   Ext3 journalling file system v2.4-0.9.19
o   update:   htree ext3 directory indexing 2.4.19-4-dxdir
o   update:   JFS v1.0.24
o   update:   Enterprise Volume Management System (EVMS) v1.2.0 final
o   update:   CryptoAPI v2.4.19-2
o   update:   HTB v3.6 fix
o   update:   grsecurity v1.9.7d (CVS/Bugfixes update)
o   update:   CPU Frequency Scaling v2.4.19-9
o   change:   Moved every "Journalling Filesystem" in an extra menu option
o   change:   include/net/pkt_sched.h: clocksource is now PSCHED_CPU
o   removed:  Timepegs 2.4.19-pre6-1 (dunno how to integrate this with o1)
o   removed:  Lock-Break 2.4.18-1 (no longer maintained, Low Latency in place)
o   removed:  Fair Scheduler (per user scheduling) 2.4.19 2nd edition (no o1)
o   removed:  AIO (dunno how to integrate this with o1)
o   removed:  CTX (dunno how to integrate this with o1)


Release Info:
-------------
Date   : October, 23th, 2002
Time   : 11:00 pm CET
URL    : http://sf.net/projects/wolk


md5sums:
--------
75b27881c0be2c8c15aad286d354caa2 *linux-2.4.18-wolk3.6-to-3.7.patch.bz2
d33fe309c4323b2ae5d92c2538f31d53 *linux-2.4.18-wolk3.6-to-3.7.patch.gz
aff3d427a8ed37d9ddafb83b31714e09 *linux-2.4.18-wolk3.7-fullkernel.tar.bz2
5ce10d4f14d360aac135560a1f614ab1 *linux-2.4.18-wolk3.7-fullkernel.tar.gz
d074198cd6e6309992dd30ed7249a08e *linux-2.4.18-wolk3.7-patch.patch.bz2
24e993a794d136411ee41c973b07b523 *linux-2.4.18-wolk3.7-patch.patch.gz
efa8f28d02d9e39103bd6c816aecf139 *linux-2.4.18-wolk3.7-patchset.tar.bz2
cd76ef2325be3181def8e05ce5b18d87 *linux-2.4.18-wolk3.7-patchset.tar.gz


Have fun!


-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


