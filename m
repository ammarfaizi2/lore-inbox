Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315009AbSDWCAc>; Mon, 22 Apr 2002 22:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315020AbSDWCAb>; Mon, 22 Apr 2002 22:00:31 -0400
Received: from mail.mojomofo.com ([208.248.233.19]:9988 "EHLO mojomofo.com")
	by vger.kernel.org with ESMTP id <S315009AbSDWCAa>;
	Mon, 22 Apr 2002 22:00:30 -0400
Message-ID: <051a01c1ea6a$915711c0$0800a8c0@atlink30g>
From: "Richard Toilet" <mojomofo@mojomofo.com>
To: <linux-kernel@vger.kernel.org>
Subject: [2.5.5 to 2.5.7+] Something broke my squid cache
Date: Mon, 22 Apr 2002 21:59:56 -0400
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


Going from 2.5.5 to 2.5.7 makes my squid cache serve out runt packets to any
client that is on my intra-net but not external sources (eth0 in/out is
fine, eth0 in/eth1 out is broken)..

This is definitely kernel related because I can downgrade from 2.5.7 to
2.5.5 and everything works as expected. I upgraded/downgraded squid versions
and it didn't make any difference so I'm wondering if something netfilter
related has changed. Both nics are Intel eepro100's, and it occurs using the
intel and the modified becker driver.

Shoo.. little by little I'm working my way back to the kernel that breaks it
but if anyone else has run into this, maybe they have some insight and can
save me some work. :)

2.5.9 has the same problem, but at least TCQ works and is enabled on my
'can't trust it' 30GB IBM DeskStar. :)
I am going to put in my 120GB WD drive tonite also, to give Jens more
datapoints. These 8MB cache versions are ungodly fast.


