Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286204AbRLJJwH>; Mon, 10 Dec 2001 04:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286205AbRLJJv5>; Mon, 10 Dec 2001 04:51:57 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:8413 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S286204AbRLJJvt>; Mon, 10 Dec 2001 04:51:49 -0500
Date: Mon, 10 Dec 2001 10:51:44 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: linux-kernel@vger.kernel.org
Subject: Patches in 2.4.17-pre2 that aren't in 2.5.1-pre8
Message-ID: <Pine.NEB.4.43.0112101032230.4997-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

patches that go into the stable kernel should also go into the development
kernel. I was wondering how good this works and I was surprised that only
few patches that were applied to the 2.4 kernels also went into the 2.5
kernels. Below is a list of patches in 2.4.17-pre2 that are missing in
2.5.1-pre8. The name below the changelog entries is the name of the file
if you download the missing patches from [1].

Before applying them they need to be checked: Most of the patches apply
cleanly but there are some (most of them trivial) rejects and what's more
important: I checked whether the patches seem to be missing from
2.5.1-pre8, not whether they compile or produce working code.

I don't know whether this work is redundant, I was mostly interested in
how much of the patches in the 2.4 kernels went into the 2.5 kernels. If
it helps other people I can continue it up to more recent 2.4 kernels.

Any comments are welcome.

cu
Adrian

[1] http://www.fs.tum.de/~bunk/kernel/missing-2.4.17pre2-2.5.1pre8.tar.gz


2.4.16-pre1
- Make pagecache readahead size tunable via /proc          (was in -ac tree)
  2.4.16-pre1-readahead-tuneable
- Fix PPC kernel compilation problems                      (Paul Mackerras)
  2.4.16-pre1-ppc-compile


2.4.17-pre1
- Speeling fix for rd.c                         (From Ralf Baechle's tree)
  2.4.17-pre1-rd.c-spelling
- Updated URL for bigphysmem patch in v4l docs  (Adrian Bunk)
  2.4.17-pre1-bigphysmem-url
- Add buggy 440GX to broken pirq blacklist      (Arjan Van de Ven)
  2.4.17-pre1-440GX-broken_pirq
- Add new entry to Sound blaster ISAPNP list    (Arjan Van de Ven)
  2.4.17-pre1-soundblaster-isapnp
- Update osst sound driver to 1.65              (Willem Riede)
  [this is a SCSI Tape Driver]
  2.4.17-pre1-osst-update
- Fix i810 sound driver problems                (Andris Pavenis)
  2.4.17-pre1-i810-fix
- Add AF_LLC define in network headers          (Arnaldo Carvalho de Melo)
  [really added in pre2]
  2.4.17-pre2-network-headers-llc-define
- block_size cleanup on some SCSI drivers       (Erik Andersen)
  2.4.17-pre1-scsi-block_size
- Added missing MODULE_LICENSE("GPL") in some   (Andreas Krennmair)
  modules
  2.4.17-pre1-module-license
- Updated i8k driver                            (Massimo Dal Zoto)
  2.4.17-pre1-i8k-update
- devfs update                                  (Richard Gooch)
  [part of it was already merged in 2.5.1-pre2; Richard has separate
   patches for the 2.5 series]


2.4.17-pre2
- Remove userland header from bonding driver    (David S. Miller)
  2.4.17-pre2-bonding-remove-userland-header
- Unregister devices at shaper unload time      (David S. Miller)
  2.4.17-pre2-shaper-unload-register-devices
- Remove several unused variables from various
  places in the kernel                          (David S. Miller)
  [patch to drivers/md/lvm-snap.c is already in 2.5]
  2.4.17-pre2-remove-unused-variables
- Fix RTC driver bug                            (David S. Miller)
  2.4.17-pre2-rtc-bugfix
- SPARC 32/64 update                            (David S. Miller)
  2.4.17-pre2-sparc-update
- W9966 V4L driver update                       (Jakob Jemi)
  2.4.17-pre2-W9966-update
- Fix PCMCIA problem with multiple PCI busses   (Paul Mackerras)
  2.4.17-pre2-pcmcia-fix-pci
- IA64 PAL/signal headers cleanup               (Nathan Myers)
  2.4.17-pre2-ia64-headers-cleanup
- Change NLS "licenses" to be "GPL/BSD" instead
  only BSD.                                     (Robert Love)
  2.4.17-pre2-nls-correct-licenses
- Fix serial module use count                   (Russell King)
  2.4.17-pre2-serial-fix-use-count
- ieee1394 update                               (Ben Collins)
  2.4.17-pre2-ieee1394-update
- ReiserFS fixes                                (Nikita Danilov)
  [the fix to fs/reiserfs/journal.c is already in 2.5]
  2.4.17-pre2-reiserfs-fixes
- Smarter atime update                          (Andrew Morton)
  2.4.17-pre2-atime-smarter-update
- Correctly mark ext2 sb as dirty and sync it   (Andrew Morton)
  2.4.17-pre2-ext2-sb-mark-correctly-dirty
- [changes to intermezzo and jbd.h]
  2.4.17-pre2-misc

- Update sg to 3.1.22                           (Douglas Gilbert)
  [s/sg/cs/ ?]
- PCMCIA update                                 (David Hinds)
  2.4.17-pre2-pcmcia





