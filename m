Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290192AbSBKTH7>; Mon, 11 Feb 2002 14:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290185AbSBKTHm>; Mon, 11 Feb 2002 14:07:42 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52486 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290125AbSBKTH0>; Mon, 11 Feb 2002 14:07:26 -0500
Date: Mon, 11 Feb 2002 14:05:59 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <E16a4Ly-0000EN-00@starship.berlin>
Message-ID: <Pine.LNX.3.96.1020211140359.642A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2002, Daniel Phillips wrote:

> On February 9, 2002 07:15 pm, Bill Davidsen wrote:
> > On Wed, 6 Feb 2002, Randy.Dunlap wrote:
> > 
> > > I still prefer your suggestion to append it to the kernel image
> > > as __initdata so that it's discarded from memory but can be
> > > read with some tool(s).
> > 
> > The problem is that it make the kernel image larger, which lives in /boot
> > on many systems. Putting it in a module directory, even if not a module,
> > would be a better place for creative boot methods, of which there are
> > many.
> 
> You don't seem to be clear on the concept of 'option'.

Did I miss discussion of an option to put it somewhere other than as part
of the kernel? Sorry, I missed that.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

