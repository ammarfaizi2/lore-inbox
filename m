Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267532AbRHOWII>; Wed, 15 Aug 2001 18:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267620AbRHOWH7>; Wed, 15 Aug 2001 18:07:59 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:61108 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S267579AbRHOWHv>;
	Wed, 15 Aug 2001 18:07:51 -0400
Message-Id: <m15X8pQ-000PX7C@amadeus.home.nl>
Date: Wed, 15 Aug 2001 23:07:56 +0100 (BST)
From: arjan@fenrus.demon.nl
To: akpm@zip.com.au (Andrew Morton)
Subject: Re: Dell I8000, 2.4.8-ac5 and APM
cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B7AF05C.29521C46@zip.com.au>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B7AF05C.29521C46@zip.com.au> you wrote:

> I occasionally hear rumours about 3c59x failing with suspend/resume,
> but It Works For Me and nobody has stepped up with a solid problem
> description.  If someone _can_ reproduce this and is prepared to
> work it a bit, please let me know.

What I've seen so far is that it's not just enough to save your driver's
state, as some bioses also forget to restore the bridge your card is on.

I've a tentative fix I want to let loose on dwmw2's laptop tomorrow

