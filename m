Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSE3AUA>; Wed, 29 May 2002 20:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315943AbSE3AT7>; Wed, 29 May 2002 20:19:59 -0400
Received: from hera.cwi.nl ([192.16.191.8]:51914 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315942AbSE3AT5>;
	Wed, 29 May 2002 20:19:57 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 30 May 2002 02:19:55 +0200 (MEST)
Message-Id: <UTC200205300019.g4U0JtH24034.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, dalecki@evision-ventures.com
Subject: Re: [PATCH] 2.5.18 IDE 73
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Ahhh... wait a moment you are the one who is responsible for
    util-linux - wouldn't you care to take a bunch of patches?!

Of course - improvements are always welcome.
(But I try to be slightly more careful than you are.
Util-linux runs on all libc's and all kernels, from libc4 to glibc2
and from 0.99 to 2.5. So, changes must be compatible.)

    No need to inevent here. No need to do the book keeping in kernel.

Some need. Things like mount-by-label want to know what partitions
exist in order to look at the labels on each.
Yes, we really need a list of disk-like devices.
The gendisk chain.

Andries

