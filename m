Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSHIRnC>; Fri, 9 Aug 2002 13:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSHIRnC>; Fri, 9 Aug 2002 13:43:02 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:45480 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S315358AbSHIRnB>;
	Fri, 9 Aug 2002 13:43:01 -0400
Date: Fri, 9 Aug 2002 11:40:50 -0600
From: yodaiken@fsmlabs.com
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@arcor.de>, frankeh@watson.ibm.com,
       davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: large page patch (fwd) (fwd)
Message-ID: <20020809114050.A23656@hq.fsmlabs.com>
References: <Pine.LNX.4.44L.0208091317220.23404-100000@imladris.surriel.com> <Pine.LNX.4.44.0208090951570.1436-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208090951570.1436-100000@home.transmeta.com>; from torvalds@transmeta.com on Fri, Aug 09, 2002 at 09:52:53AM -0700
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 9 Aug 2002, Rik van Riel wrote:
> One problem we're running into here is that there are absolutely
> no tools to measure some of the things rmap is supposed to fix,
> like page replacement.

But page replacement is a means to an end. One thing tht would be
very interesting to know is how well the basic VM assumptions about
locality work in a Linux server, desktop, and embedded environment.

You have a LRU approximation that is supposed to approximate working
sets that were originally understood and measured on < 1Meg machines
with static libraries, tiny cache,  no GUI and no mmap.

L.T. writes:

> Read up on positivism.

It's been discredited as recursively unsound reasoning.

---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

