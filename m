Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131873AbRDACBS>; Sat, 31 Mar 2001 21:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131878AbRDACBI>; Sat, 31 Mar 2001 21:01:08 -0500
Received: from radix.rossi.com ([198.136.189.98]:1664 "EHLO mantissa.rossi.com")
	by vger.kernel.org with ESMTP id <S131873AbRDACAx>;
	Sat, 31 Mar 2001 21:00:53 -0500
Date: Sat, 31 Mar 2001 20:59:56 -0500 (EST)
From: Bill Rossi <bill@rossi.com>
To: linux-kernel@vger.kernel.org
Subject: Loopback device hangs on mount command
Message-ID: <Pine.LNX.3.95.1010331205249.371A-100000@mantissa.rossi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] Loopback device hangs on mount command.

[2.] Mounting a loopback device hangs the process.  Eg.  Issuing

     losetup /dev/loop0 fsimg
     mount /dev/loop0 /mnt

     will hang at the mount command.  The mount process cannot be
     killed, nor can the loopback device be destroyed with losetup.

[3.] modules kernel loop
[4.] Linux mantissa 2.4.2 #15 Wed Mar 28 11:00:17 EST 2001 i686

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux mantissa 2.4.2 #15 Wed Mar 28 11:00:17 EST 2001 i686
Kernel modules         2.4.3
Gnu C                  2.95.2
Gnu Make               3.75
Binutils               2.6.0.14
Linux C Library        5.4.46
Dynamic linker         ldd: version 1.9.9
Linux C++ Library      27.1.4
Linux C++ Library      10.0.so
Procps                 0.99
Mount                  2.10s
Net-tools              V
Kbd                    0.89
Sh-utils               1.12
Modules Loaded         sg loop isofs sr_mod cdrom ide-scsi aic7xxx 3c59x unix serial es1371 ac97_codec uart401 sound soundcore

Thank you,
Bill Rossi


