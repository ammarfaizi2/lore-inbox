Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267036AbSK2NVN>; Fri, 29 Nov 2002 08:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267038AbSK2NVM>; Fri, 29 Nov 2002 08:21:12 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:46316 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267036AbSK2NVL> convert rfc822-to-8bit; Fri, 29 Nov 2002 08:21:11 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: wolk-devel@lists.sourceforge.net, wolk-announce@lists.sourceforge.net
Subject: [ANNOUNCE] WOLK v3.8 FINAL // [PATCH | PATCHSET | FULLKERNEL | UPDATE]
Date: Fri, 29 Nov 2002 14:27:10 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211291427.10848.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

When I released 3.7 FINAL I said development for 3.x series has stopped, but I 
cannot stop ... It's just like a drug ;) ... Next release will be definitively 
WOLK4.0 with 2.4.20 ... Just waiting for O(1), Lowlat, Preempt for O(1) 
patches for 2.4.20 ...

I guess you'll like this release very much!


Changelog from v3.7.1 -> v3.8
-----------------------------
o   add:     Lot's of missing documentation for config options
o   add:     Athlon-Tbird/Athlon-4/Athlon-MP config + >= gcc 3.x flags
o   add:     2.4.19 rivafb updates
o   add:     Mini Lowlatency Elevator with config option
              - Tired of all those pauses while doing high disk i/o?
              - Tired of all the stops while doing that?
               If all is yes, this is for YOU! :)
o   add:     Allow users within a special GID to change their nice level   
              from (-20 to 19). Enable this via config option and re-define
              this via /proc/sys/kernel/renice_gid. The default GID is 11.
o   add:     SquashFS v1.0c + modifications to work with shared ZLIB
              + Documentation/filesystems/squashfs.txt + CONFIG entry
              + Fix for mksquashfs userspace tools
o   add:     Magic SysRq Key to emulate Alt-SysRq-key
              Usage: echo {key} > /proc/sys/kernel/magickey
               For example: echo s > /proc/sys/kernel/magickey for an
                            emergency sync :)
o   add:     HTREE backward compatibility patch for ext2
o   add:     ext2|ext3|htree updates pending for 2.4.20
              + Orlov Block Allocator for ext2|ext3
o   add:     Orlov allocator directory accounting bug
o   add:     Promise PDC20xxx Documentation updates
o   add:     Wireless Extensions v15 (new driver API) + some new wavelans
              (Thanks to Georg Lukas for the WOLK patch)
o   add:     Antidote2 - to resisting ARP spoofing
              (Read Documentation/networking/antidote2.txt for more info)
              (request by Thomas Kuepper)
o   add:     ALi5455 audio support
o   add:     3-ware driver update 1.02.00.031
o   add:     IBM x440 Summit support
+   add:     Artop 865/865R IDE chipset support (ATP865)
+   re-add:  BadRAM v4.9
              (Thanks to Michael A. Kreitzer for the WOLK patch)
o   re-add:  CPU - Cap Processor Usage
              allowing to limit processor usage (by percentage)
              for a given task (cap binary in WOLK-tools package)
              (request by Christian Beyerlein)
o   fixed:   IDE Partition check hang with external IDE Controllers
              (Thanks to Christian Beyerlein for the time to hunt this down)
+   fixed:   IP Personality compile issue
o   fixed:   Fix lcall DoS
o   fixed:   can't allow userspace to set NT
o   fixed:   locking bug in wait_on_page/wait_on_buffer/get_request_wait
o   fixed:   Awfull slow SCSI performance if CONFIG_HIGHIO is not selected
o   fixed:   ISDN multichannel crash
o   fixed:   hopefully really fixed unresolved symbol tcp_v4_lookup_listener
o   fixed:   sysctl value kdb was in the wrong place
o   fixed:   Some gcc-3.2.x warnings
o   fixed:   avidemux crashed
              (Thanks to Moritz Muehlenhoff for noticing this)
o   fixed:   IDE-CD non-working
              (Thanks to Moritz Muehlenhoff for noticing this)
o   fixed:   speed up ext2|ext3 mounts again a bit
o   update:  CPU Frequency Scaling v2.4.19-11
o   update:  Compressed Cache v0.24-pre5
o   update:  XFree v4.3.0 DRM/DRI Drivers from 2.4.20-rc2-ac3 tree + Fix
              to support upcoming XFree v4.3
              XFree86 release with the Linux bug fixes
              restored and a lot of noise/junk removed
o   update:  IBM's NGPT2 (Next Generation Posix Threading 2) v2.0.4
o   update:  "Super" FreeS/WAN 1.99 includes:
              X.509 0.9.15, Notify/Delete SA,
              NAT Traversal 0.4 and ALG 0.8
o   update:  JFS v1.1.0
o   update:  IPVS v1.0.7
o   update:  grsecurity v1.9.8-CVS as of 2002-11-29
o   update:  XFS v1.2-pre3
o   update:  KDB v2.5
o   update:  i2c v2.6.6-cvs-2002-11-29
o   update:  lmsensors v2.6.6-cvs-2002-11-29
o   update:  Kernel Message Dumper v0.4.4
o   change:  some read-ahead values for performance



Release Info:
-------------
Date   : November, 29th, 2002
Time   : 2:00 pm CET
URL    : http://sf.net/projects/wolk


md5sums:
--------
958b1e912b16c999ccec73d9758e559e *linux-2.4.18-wolk3.7.1-to-3.8.patch.bz2
c017cbcc3fc8093c94fb700c79f387b9 *linux-2.4.18-wolk3.7.1-to-3.8.patch.gz
09a514078c6d8a72f3c5b846abb61236 *linux-2.4.18-wolk3.8-fullkernel.tar.bz2
23bac7605413dc2948021658beec3e5c *linux-2.4.18-wolk3.8-fullkernel.tar.gz
ee00cfa9d1e56ff67a4ed758c8891ce7 *linux-2.4.18-wolk3.8-patch.patch.bz2
9587264de34d70ea40f830856cfe73ef *linux-2.4.18-wolk3.8-patch.patch.gz
4d6334fe76f1a3e4123e23baeef1b927 *linux-2.4.18-wolk3.8-patchset.tar.bz2
40852507b5dc0571662b519785f0f6b5 *linux-2.4.18-wolk3.8-patchset.tar.gz


Have fun!

--
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
