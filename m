Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316194AbSFDMGW>; Tue, 4 Jun 2002 08:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316593AbSFDMGV>; Tue, 4 Jun 2002 08:06:21 -0400
Received: from [80.63.7.130] ([80.63.7.130]:6 "EHLO coplin19.mips.com")
	by vger.kernel.org with ESMTP id <S316194AbSFDMGT>;
	Tue, 4 Jun 2002 08:06:19 -0400
Date: Tue, 4 Jun 2002 14:06:15 +0200 (CEST)
From: Kjeld Borch Egevang <kjelde@mips.com>
To: linux-kernel@vger.kernel.org
Subject: sys_time() not working on 64-bit processor
Message-ID: <Pine.LNX.4.44.0206041356400.7022-100000@coplin19.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently running on a 64-bit version of Linux on a MIPS processor
(int == 32 bit, long == 64 bit). I noticed that the time() system call did
not work.

Is there any reason why sys_time() (and sys_stime()) in kernel/time.c is
defined with an int pointer?



/Kjeld

