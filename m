Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282288AbRK2CWC>; Wed, 28 Nov 2001 21:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282290AbRK2CVw>; Wed, 28 Nov 2001 21:21:52 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:10744 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S282288AbRK2CVq>; Wed, 28 Nov 2001 21:21:46 -0500
Date: Wed, 28 Nov 2001 21:24:29 -0500
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: fsync02 test hangs 2.5.1-pre3 + patch
Message-ID: <20011128212429.A155@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.1-pre3 with patch http://marc.theaimsgroup.com/?l=linux-kernel&m=100699614529904&w=4

LTP Test: fsync02 - Create a sparse file, fsync it, and time the fsync

Test usually takes about 3 seconds.

Symptoms after the test started:
w, login, ps do not return.
exiting mp3blaster, bash, bitchx don't return.
Sysrq Sync Unmount do not return
Sysrq showPc shows "swapper".
Sysrq tErm kIll killalL terminate some processes (ppp - wvdial).
Sysrq reBoot does not reboot.
ncftp completed downloaded of patch-2.4.17-pre1.bz2, but the file was corrupt.
(size is okay, but checksum is bad).

Linux version 2.5.1-pre3 (gcc version 2.95.3 20010315 (release)) #8 Wed Nov 28 20:18:11 EST 2001

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.2
util-linux             2.11m
mount                  2.11m
modutils               2.4.12
e2fsprogs              1.25
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0f.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)

Hope this helps.
-- 
Randy Hron

