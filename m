Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285396AbRLGDmu>; Thu, 6 Dec 2001 22:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285397AbRLGDmh>; Thu, 6 Dec 2001 22:42:37 -0500
Received: from cpe-66-1-134-68.ca.sprintbbd.net ([66.1.134.68]:14790 "HELO
	core.sitedirection.com") by vger.kernel.org with SMTP
	id <S285396AbRLGDmX>; Thu, 6 Dec 2001 22:42:23 -0500
Message-ID: <054401c17ed2$3b03a0d0$0f00a8c0@minniemouse>
From: "Jon" <marsaro@interearth.com>
To: <linux-kernel@vger.kernel.org>
Subject: TCP performance eepro100
Date: Thu, 6 Dec 2001 19:49:53 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone done testing on eepro100 and seen really poor performance? I am
seeing that the eepro100 in SuSE 2.4.7 and above is 50% slower than than
2.4.2 in RH 7.1 I am doing a simple test with ttcp against another RH server
and then SuSE vs SuSE or vs the RH system. In all cases the eepro100at best
shows 39mbs. In modules.conf I am setting options="0x30" that forces 100mbps
Full Duplex, this is also reflected in dmesg. With the new intel e100 it is
possible to get 60mbps on SuSE. Is there something in the Kernel build or
Driver build that is multi-casting or filtering that may cause this? Any
ideas at this point would help. BTW, I am using SMP Kernels on all the
systems.

Regards,

Jon


