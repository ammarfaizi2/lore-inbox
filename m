Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270280AbRHWUqo>; Thu, 23 Aug 2001 16:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270293AbRHWUqd>; Thu, 23 Aug 2001 16:46:33 -0400
Received: from smarty.smart.net ([207.176.80.102]:4364 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S270299AbRHWUq0>;
	Thu, 23 Aug 2001 16:46:26 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200108232108.RAA21070@smarty.smart.net>
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
To: linux-kernel@vger.kernel.org
Date: Thu, 23 Aug 2001 17:08:14 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen
I am actually much more concerned about bringing up new systems than
embedded however it is not uncommon to have very limited space to work
in (like 64MB). My point is that the transport process of the kernel
image is painful. Some of the embedded devices or new systems being
brought up may only have serial some do not have network or
floppy. This makes it *very* painful to move things around because you
have to physically move your disk or similar. In particular when
bringing up a system you tend to disable large parts of the kernel in

moi
 In other words, a kernel build has a close correlation with actual system
bootstrap processes, where the niceties of the interpreter-du-jour are
irrelvant, as are the percentages or absolute numbers of people that don't
do hard bootstrapping of anything. This is the aspect of low-level code
that utilities used in a kernel build should adhere to, no gratuitous
dependancies. Linux is and always has been hard enough to bring up,
needing as it does a C compiler that needs a C compiler. Somehow the
cuteness of this class of recursion is lost on me. 

This is why I wrote and am extending an assembler in Bash. Two
dependancies; a recent unix shell, and an OS. The one-link toolchain.

Rick Hohensee
	

	www.clienux.com

