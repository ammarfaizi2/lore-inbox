Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136009AbRDVKDj>; Sun, 22 Apr 2001 06:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136004AbRDVKDU>; Sun, 22 Apr 2001 06:03:20 -0400
Received: from quechua.inka.de ([212.227.14.2]:29756 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S136009AbRDVKDJ>;
	Sun, 22 Apr 2001 06:03:09 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: fd allocation [was: light weight user level semaphores]
In-Reply-To: <E14qHRp-0007Yc-00@the-village.bc.nu> <Pine.LNX.4.31.0104190944090.4074-100000@penguin.transmeta.com> <E14qXEU-0005xo-00@g212.hadiko.de> <9bqgvi$63q$1@penguin.transmeta.com> <3AE10741.FA4E40BD@gmx.de>
Organization: private Linux site, southern Germany
Date: Sun, 22 Apr 2001 11:48:52 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14rGU8-0003zk-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, IMHO as long as some library does not mess with fds 0, 1, and 2
> it should be ok [1].  Yes, it would be against the standard but I
>...
> [1] Unintentionally setting the controlling tty may be a problem.

The controlling tty is not what is first opened to fd 0 but what is
first opened, so this problem can occur at any time.

Olaf
