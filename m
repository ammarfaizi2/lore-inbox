Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318420AbSGSBkm>; Thu, 18 Jul 2002 21:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318422AbSGSBkm>; Thu, 18 Jul 2002 21:40:42 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:11170 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318420AbSGSBkl>;
	Thu, 18 Jul 2002 21:40:41 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Remain Calm: Designated initializer patches for 2.5 
In-reply-to: Your message of "Thu, 18 Jul 2002 15:47:07 +0200."
             <E17VBcZ-0004oO-00@starship> 
Date: Fri, 19 Jul 2002 11:32:51 +1000
Message-Id: <20020719014425.BAECB417E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E17VBcZ-0004oO-00@starship> you write:
> On Thursday 18 July 2002 05:22, Rusty Russell wrote:
> > GCC has understood both since forever, but the kernel took a wrong
> > bet, and we're better off setting a good example for 2.6 before we
> > start getting about 10,000 warnings.
> 
> Next time, remember to bet on the ugliest looking one ;-)

I agreed, until I recently did a big grep to find these things.  I now
concur with the C9X committee.  ".foo = " is clearly distinguished
from bitfield declarations and labels, which "foo: " isn't.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
