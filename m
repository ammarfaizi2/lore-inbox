Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314584AbSFITHB>; Sun, 9 Jun 2002 15:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314690AbSFITHA>; Sun, 9 Jun 2002 15:07:00 -0400
Received: from p50887457.dip.t-dialin.net ([80.136.116.87]:15268 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314584AbSFITHA>; Sun, 9 Jun 2002 15:07:00 -0400
Date: Sun, 9 Jun 2002 13:06:51 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kai Henningsen <kaih@khms.westfalen.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <Pine.LNX.4.44.0206091056550.13459-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0206091301520.8715-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Jun 2002, Linus Torvalds wrote:
> Yes, some old-timers could argue that original UNIX didn't have sockets,

Not to mention MULTICS...

IMO this all looks like "exporting program variables to filesystem", would 
you do that? (Then we'll need /dev/memory/16k/5362337156/blah, etc.) The 
next issue would be "how do we stop other processes from using our 
sockets, semaphores, etc., ending up where we started.

Sockets are a good implementation as long as they don't fall down for some 
particular purpose. This isn't given yet. Semaphores didn't yet fall down, 
either. So what do you want more? The "old" system might look crappy to 
you, but it works! It works, even if it's a little more abstract than the 
Plan-9. Are we Plan-9?

Regards,
Thunder

PS. this mail was sent through a happily working lot of sockets.
-- 
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere

