Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280554AbRKBEB3>; Thu, 1 Nov 2001 23:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280553AbRKBEBT>; Thu, 1 Nov 2001 23:01:19 -0500
Received: from [203.6.240.4] ([203.6.240.4]:39433 "HELO
	cbus613-server4.colorbus.com.au") by vger.kernel.org with SMTP
	id <S280554AbRKBEBM>; Thu, 1 Nov 2001 23:01:12 -0500
Message-ID: <370747DEFD89D2119AFD00C0F017E66150B169@cbus613-server4.colorbus.com.au>
From: Robert Lowery <Robert.Lowery@colorbus.com.au>
To: linux-kernel@vger.kernel.org
Subject: Best way to setup 128MB box that can only cache 64MB
Date: Fri, 2 Nov 2001 15:00:40 +1100 
X-Mailer: Internet Mail Service (5.5.2653.19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I know most people are now having fun on 2GB+ SMP Mega666 processor systems
these days ;), But unfortunately, I still only have a Pentium 233MMX system
as my firewall with 128MB RAM with the Intel 430FX chip which can only cache
the first 64MB.

There have been lots of discussions over the years on this topic, but I
could not find any definitive answers. How should I set this box up to get
the best performance?

Searching around on google, I found references to the slram patch
(originally found here http://www.andrew.cmu.edu/~keryan/slram/) to allow
the slower (uncached) RAM to be used as SWAP, but cannot find a current
location of this patch.  Is this patch still required if I want to use the
top 64MB of RAM as swap? (as of 2.4.13) or is there some other way to
achieve this?

I guess there is a tradeoff.  If I use the entire memory as is, there will
be an xx% impact on the system as it loads from the top down.  If I can find
(and decide to use) the slram patch, then there will be lots of copying
(swapping) of memory to/from cached/uncached memory.  At least it's faster
than diskio I guess.

Does anyone have any suggestions/recommendations regarding this age old
topic?

-Robert

