Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279997AbRK1S5i>; Wed, 28 Nov 2001 13:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279798AbRK1S52>; Wed, 28 Nov 2001 13:57:28 -0500
Received: from mail.myrio.com ([63.109.146.2]:8954 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S279927AbRK1S5X>;
	Wed, 28 Nov 2001 13:57:23 -0500
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CAE1@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Andrew Morton'" <akpm@zip.com.au>,
        =?iso-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: RE: Unresponiveness of 2.4.16
Date: Wed, 28 Nov 2001 10:56:39 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. Speaking of dbench, I tried the combination of 2.4.16,
your 2.4.16 low latency patch, and the IO scheduling patch
on my dual PIII.

After starting it up I did a dbench 32 on a 180 GB reiserfs
running on software RAID 5, just to see if it would
fall over, and during the run I got the following error/
warning message printed about 20 times on the console 
and in the kernel log:

vs-4150: reiserfs_new_blocknrs, block not free<4>

Took it to single user mode after that and ran reiserfsck, 
which printed a lot of stuff but I don't think it found any
problems.

Went back to 2.4.15-pre5 and could not reproduce the problem
on that kernel.

Torrey
