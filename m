Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292400AbSBBVz2>; Sat, 2 Feb 2002 16:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292399AbSBBVzS>; Sat, 2 Feb 2002 16:55:18 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:49649 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP
	id <S292398AbSBBVzN>; Sat, 2 Feb 2002 16:55:13 -0500
Date: Sat, 2 Feb 2002 22:55:05 +0100 (MET)
From: Lars Christensen <larsch@cs.auc.dk>
To: <linux-kernel@vger.kernel.org>, <linux-bugs@nvidia.com>
Subject: 2.4.17 agpgart process hang on crash
Message-ID: <Pine.GSO.4.33.0202022219340.29744-100000@peta.cs.auc.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi. I have experienced a problem with the combination of kernel-2.4.16,
the kernel agpgart module and NVIDIA supplied drivers. I don't know which
is the cause of the problem.

Symptoms: Whenever an OpenGL application crashes (segfault etc.), the
process hangs and can't be killed. Responds to no signals (not even 9). ps
-ef hangs, it seems, when the crashed process is to be listed (some other
processes are listed first).

Hardware: AMD Athlon 1.333HGZ, ASUS M266 motherboard (AMD761 AGP
chipset), NVIDIA GeForce2 MX400 gfx card.

The mem=nopentium option have no effect on the problem, but it doesn't
occur if I use the NVIDIA AGP drivers or kernel 2.4.16 agp drivers. I am
not able to test the 2.4.17 agpgart with other 3D hardware that nvidia.


-- 
Lars Christensen, larsch@cs.auc.dk

