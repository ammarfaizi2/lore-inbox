Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131238AbRCRQbU>; Sun, 18 Mar 2001 11:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131239AbRCRQbK>; Sun, 18 Mar 2001 11:31:10 -0500
Received: from mnh-1-07.mv.com ([207.22.10.39]:13830 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S131238AbRCRQbE>;
	Sun, 18 Mar 2001 11:31:04 -0500
Message-Id: <200103181741.MAA01766@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: David Weinehall <tao@acc.umu.se>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] big stack variables 
In-Reply-To: Your message of "Sat, 17 Mar 2001 12:39:45 +0100."
             <20010317123945.D1962@khan.acc.umu.se> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 18 Mar 2001 12:41:46 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tao@acc.umu.se said:
> ObUML (again): Any estimated time of submission to Linus?! Is this an
> early v2.5-thing, or are the changes minor enough to the rest of the
> tree to allow for an v2.4-merge? 

There are almost no changes to the rest of the tree, and none of those affect 
any of the other arches, so it's an early 2.4 thing.

The reason I've waiting this long to put it in is that UML is not a normal 
port.  With the other ports, few enough people have the relevant hardware that 
if the port isn't all that great at submission time, not many people will be 
affected.  With UML, the vast majority of Linux users (the i386-using ones) 
have the relevant platform (we could get a lot closer to 100% if owners of 
non-i386 boxes would port UML to them, hint, hint :-).

I expect that getting it into the pool will be considered something of a stamp 
of approval for UML, so a lot more people will start using it.  If it sucks, 
it will affect a large number of people, word will get around that it sucks, 
and lots of people won't give it a second chance.

So, my goal for UML when it's submitted is that it make a solid, stable, UP 
virtual machine.  You can see a measure of my progress by my TODO list, which 
I post to my devel list occasionally.  The most recent one is at 
http://www.geocrawler.com/lists/3/SourceForge/709/25/5339352/

After the 2.4 submission, I'm going to start working on some more radical 
things, like SMP emulation, clustering, and artifical environments.

				Jeff


