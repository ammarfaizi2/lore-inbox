Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278800AbRKOHlL>; Thu, 15 Nov 2001 02:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278911AbRKOHlB>; Thu, 15 Nov 2001 02:41:01 -0500
Received: from auucp0.ams.ops.eu.uu.net ([195.129.70.39]:30383 "EHLO
	auucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S278800AbRKOHkz>; Thu, 15 Nov 2001 02:40:55 -0500
Date: Thu, 15 Nov 2001 08:39:30 +0100 (CET)
From: kees <kees@schoen.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Q: straced processes don't go away
Message-ID: <Pine.LNX.4.33.0111150836290.20276-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

In my attempts to find the problem with the tun device I did
a couple of strace sessions.

My processlist now shows a couple of unkillable (kill -KILL )
processes:

444     0 24239     1   9   0     0    0 do_exi RW   ?          0:00
[vtund]
444     0 24305     1   8   0     0    0 do_exi RW   ?          0:00
[vtund]
444     0 24880     1   9   0     0    0 do_exi RW   ?          0:00
[vtund]

kernel 2.4.14 with 2.4.15-pre3 applied

Kees

