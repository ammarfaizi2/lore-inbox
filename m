Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318912AbSH1TUl>; Wed, 28 Aug 2002 15:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318917AbSH1TUl>; Wed, 28 Aug 2002 15:20:41 -0400
Received: from zeus.kernel.org ([204.152.189.113]:49116 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S318912AbSH1TUk>;
	Wed, 28 Aug 2002 15:20:40 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Manfred Spraul <manfred@colorfullife.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
Date: Wed, 28 Aug 2002 20:35:09 +0200
Message-Id: <20020828183509.29741@192.168.4.1>
In-Reply-To: <Pine.LNX.4.33.0208281030190.1735-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0208281030190.1735-100000@penguin.transmeta.com>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I agree. There is absolutely no reason to artificially limit the "bus" 
>structure to only three resoruces (and with hardcoded behaviour at that).
>
> .../...
>
>In short: if anything, we may at some point make the number of resources
>_larger_, not smaller.

What about removing that hard coded 4 where ever it lives, and either
do a #define (that could eventually be overriden by arch) or do a
dynamically allocated array ? If you are ok with that, I'll put that
on my list of things to do when I get back to moving the pmac drivers
to 2.5

Ben.


