Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSEWVWw>; Thu, 23 May 2002 17:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317013AbSEWVWv>; Thu, 23 May 2002 17:22:51 -0400
Received: from acolyte.thorsen.se ([193.14.93.247]:29971 "HELO
	acolyte.hack.org") by vger.kernel.org with SMTP id <S317012AbSEWVWv>;
	Thu, 23 May 2002 17:22:51 -0400
From: Christer Weinigel <wingel@acolyte.hack.org>
To: dalecki@evision-ventures.com
Cc: torvalds@transmeta.com, zaitcev@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <3CED438B.6090906@evision-ventures.com> (message from Martin
	Dalecki on Thu, 23 May 2002 21:31:23 +0200)
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-Id: <20020523212239.EA736F5B@acolyte.hack.org>
Date: Thu, 23 May 2002 23:22:39 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki <dalecki@evision-ventures.com> wrote:

> "I will submitt my dual 8255 PIO ISA card driver from 1.xx days
> immediately for kernel inclusion"

Please do *grin* I will probably have to write a driver for just such
a card (a PC104 card though, but that's just a differenct connector),
so I'd love to have such a driver.  And as long as the driver is
self-contained and doesn't mess with other parts of the kernel I can't
see why it shouldn't be included in Linus' tree.  The same is IMHO
true about /dev/port, it's rather self-contained and is less than 50
source lines in mem.c.  It may be ugly but it's useful for some people.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"
