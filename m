Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280320AbRKNIFK>; Wed, 14 Nov 2001 03:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280307AbRKNIFA>; Wed, 14 Nov 2001 03:05:00 -0500
Received: from auucp0.ams.ops.eu.uu.net ([195.129.70.39]:64421 "EHLO
	auucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S280320AbRKNIEs>; Wed, 14 Nov 2001 03:04:48 -0500
Date: Wed, 14 Nov 2001 09:00:35 +0100 (CET)
From: kees <kees@schoen.nl>
To: <linux-kernel@vger.kernel.org>
Subject: strace + tun
Message-ID: <Pine.LNX.4.33.0111140858230.4202-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In my attempt to learn more about vtund I did a few strace sessions.
They are unkillable after, ps axl:

000     0 16717 16716   9   0  2500  928 read_c S    pts/3      0:00 -bash
444     0 24239     1   9   0     0    0 do_exi RW   ?          0:00
[vtund]
444     0 24305     1   8   0     0    0 do_exi RW   ?          0:00
[vtund]
444     0 24880     1   9   0     0    0 do_exi RW   ?          0:00
[vtund]

Kernel 2.4.14 + patch-2.4.15pre applied.

Kees

