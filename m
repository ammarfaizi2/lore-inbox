Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbTBOUFK>; Sat, 15 Feb 2003 15:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbTBOUFK>; Sat, 15 Feb 2003 15:05:10 -0500
Received: from [212.122.164.10] ([212.122.164.10]:64661 "EHLO
	pechkin.minfin.bg") by vger.kernel.org with ESMTP
	id <S265074AbTBOUFJ>; Sat, 15 Feb 2003 15:05:09 -0500
From: "Kostadin Karaivanov" <larry@minfin.bg>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG] setkey -DP freezes 2.5.61
Date: Sat, 15 Feb 2003 22:14:04 +0200
Message-ID: <000001c2d52e$cb318fb0$04010101@laptop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Software - racoon and setkey precompiled binarys from
http://ds9a.nl/ipsec/ Kernel 2.5.61
 
I have trying to build ipsec tunnel between my home-lan
router(linux) and my work(Checkpoint FW-1 NG FP3). 
Seting SPD using setkey spdadd x.x.x.0/24 y.y.y.0/24 any -P in ipsec
esp/tunnel/gate-home-gate-work/require went just fine Than I fire up
racoon in foreground for debugging and start to ping from internal host
of my home-lan, during the ping a lot of info is scrolling on console
where I have raccoon, on another ssh console I try to issue setkey -DP
To see my SPD, and here comes freeze. 
No ping no login. 
Running setkey -D works.
Running setkey _DP works when raccoon is not runnig.   
Kernel .config is pretty modest I can post it if needed. Nothing
interesting in logs except racoon output that has some ERROR lines.
 
Any help/hint will be greatly appreciated

Wwell Larry.

