Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315410AbSELUCY>; Sun, 12 May 2002 16:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315411AbSELUCX>; Sun, 12 May 2002 16:02:23 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:42085 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S315410AbSELUCW>;
	Sun, 12 May 2002 16:02:22 -0400
Message-ID: <002801c1f9ef$e1e5fa90$0201a8c0@witek>
From: =?iso-8859-2?Q?Witek_Kr=EAcicki?= <adasi@kernel.pl>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG 2.5.X] Hollow processes
Date: Sun, 12 May 2002 22:01:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Had the same problem on 2.5.9 with poldek, now it appeared on 2.5.15dj1
while building glibc-2.5.4 to rpm)
Process is hanging. It's impossible to stop it (even SAK is just clearing
console). It's impossible to check what the process is (trying to read
/proc/{pid}/{anyting} causes reading process to hang in the same way (so we
have now 2 hanging processes). Trying to use ps/lsof/killall/{anything that
is using /proc/{pid} causes this software hang in the same way. What could
it be?
WK


