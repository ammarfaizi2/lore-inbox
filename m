Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287212AbSAUQCR>; Mon, 21 Jan 2002 11:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287254AbSAUQCH>; Mon, 21 Jan 2002 11:02:07 -0500
Received: from dsl-213-023-039-080.arcor-ip.net ([213.23.39.80]:20105 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287212AbSAUQB5>;
	Mon, 21 Jan 2002 11:01:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: yodaiken@fsmlabs.com
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 21 Jan 2002 17:05:01 +0100
X-Mailer: KMail [version 1.3.2]
Cc: yodaiken@fsmlabs.com, george anzinger <george@mvista.com>,
        Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16SgXE-0001i8-00@starship.berlin> <20020121084344.A13455@hq.fsmlabs.com>
In-Reply-To: <20020121084344.A13455@hq.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16SgwP-0001iN-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 21, 2002 04:43 pm, yodaiken@fsmlabs.com wrote:
> On Mon, Jan 21, 2002 at 04:38:59PM +0100, Daniel Phillips wrote:
> > On January 15, 2002 01:39 pm, yodaiken@fsmlabs.com wrote:
> > > My reservation about preemption as an implementation technique is that
> > > it has costs, which seem to be not easily boundable, but not very 
> > > clear benefits.
> > 
> > To me the benefit is clear enough: ASAP scheduling of IO threads, a 
> > simple heuristic that improves both throughput and latency.
> 
> I think of "benefit", perhaps naiively, in terms of something that can
> be measured or demonstrated rather than just announced.

But you see why asap scheduling improves latency/throughput *in theory*, 
don't you?  As for the measured benefit, there have been a steady stream of 
postive reports on lkml.  My own experience is that the usability of my 
laptop with its small memory is much improved under heavy IO load.

--
Daniel
