Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310283AbSCPLyL>; Sat, 16 Mar 2002 06:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310285AbSCPLyB>; Sat, 16 Mar 2002 06:54:01 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:50696 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S310283AbSCPLxt>;
	Sat, 16 Mar 2002 06:53:49 -0500
Date: Sat, 16 Mar 2002 04:54:49 -0700
From: yodaiken@fsmlabs.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
Message-ID: <20020316045449.A14161@hq.fsmlabs.com>
In-Reply-To: <20020313085217.GA11658@krispykreme> <20020316061535.GA16653@krispykreme> <a6uubq$uqr$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <a6uubq$uqr$1@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Mar 16, 2002 at 08:05:14AM +0000
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 08:05:14AM +0000, Linus Torvalds wrote:
> It would also be interesting to hear if you can just make the hash table
> smaller (I forget the details of 64-bit ppc VM horrors, thank God!) or
> just bypass it altogether (at least the 604e used to be able to just
> disable the stupid hashing altogether and make the whole thing much
> saner). 

Reference:
URL: http://www.usenix.org/ Optimizing the Idle Task and Other MMU Tricks
Cort Dougan, Paul Mackerras, Victor Yodaiken
www.usenix.org/publications/library/proceedings/osdi99/full_papers/dougan/dougan.pdf


Cort's MS thesis was on this topic. IBM seems reluctant to give up on 
hardware page tables though.


