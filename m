Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRB0UBw>; Tue, 27 Feb 2001 15:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129819AbRB0UBm>; Tue, 27 Feb 2001 15:01:42 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:19417 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S129084AbRB0UBd>; Tue, 27 Feb 2001 15:01:33 -0500
Date: Tue, 27 Feb 2001 15:06:06 -0500 (EST)
From: Rob <rob@hereintown.net>
To: <linux-kernel@vger.kernel.org>
Subject: Compilation problems
Message-ID: <Pine.LNX.4.30.0102271442010.967-100000@robsdigs.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I've encountered a problem compiling the 2.4.2 kernel.

I downloaded the source, did a make menuconfig, make dep, make bzImage;
everything went ok, but I didn't have the NIC working correctly. I
recompiled, it seemed to go ok but still the NIC didn't work.  Then I
tried make clean, make mrproper, make menuconfig, make dep, make bzImage,
and now I keep getting an error at the very end of the compile process...

init/main.o(.text.init+0x53): undefined reference to
`__buggy_fxsr_alignment'
make: ***[vmlinux] Error 1

I've even tried removing the source tree and re extracting from the tar
ball again but it always stops at the same place now.  If you have any
ideas, please let me know.  I'm not a member of the list so a cc would
really be great.

-- 
Rob Connor
TWR Communications
301 777 2692 x131
rob@hereintown.net

Good judgement comes from experience, and experience -
well, that comes from poor judgement.


