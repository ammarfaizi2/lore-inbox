Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263225AbRFMFEo>; Wed, 13 Jun 2001 01:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264544AbRFMFEe>; Wed, 13 Jun 2001 01:04:34 -0400
Received: from [195.163.165.35] ([195.163.165.35]:2313 "EHLO vic20.blipp.com")
	by vger.kernel.org with ESMTP id <S263225AbRFMFEX>;
	Wed, 13 Jun 2001 01:04:23 -0400
Date: Wed, 13 Jun 2001 07:03:59 +0200 (CEST)
From: Patrik Wallstrom <pawal@blipp.com>
To: Larry McVoy <lm@bitmover.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: double entries in /proc/dri?
In-Reply-To: <20010612185603.A2031@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0106130659070.18749-100000@vic20.blipp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2001, Larry McVoy wrote:

> This is cute:
>
> $ ls -li /proc
> ...
>    4106 -r--r--r--    1 root     root            0 Jun 12 18:53 dma
>    4347 dr-xr-xr-x    3 root     root            0 Jun 12 18:53 dri
>    4347 dr-xr-xr-x    3 root     root            0 Jun 12 18:53 dri
>    4121 dr-xr-xr-x    2 root     root            0 Jun 12 18:53 driver
> ...
>
> $ uname -a
> Linux work.bitmover.com 2.4.5 #1 Mon May 28 10:54:32 PDT 2001 i686 unknown
>
> Repeatable.  If other users of 2.4.5 do NOT see this, please let me know.

Linux pawalski.blipp.com 2.4.5-0.2.9 #1 Wed May 30 06:50:52 EDT 2001 i686 unknown

This is the Red Hat kernel from rawhide.

-r--r--r--    1 root     root            0 Jun 13 06:59 dma
dr-xr-xr-x    2 root     root            0 Jun 13 06:59 driver
-r--r--r--    1 root     root            0 Jun 13 06:59 execdomains

However, I saw this on a self compiled 2.4.4 with Cisco 350 PC-Card
installed using pcmcia-cs and the Cisco airo_cs.o module up and running.

--
 patrik wallstrom     |      f o o d f i g h t
 tel: +46-8-6188428   |      s t o c k h o l m
 gsm: +46-708405080   |      - - - - - - - - -


