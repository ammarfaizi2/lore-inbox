Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268308AbUGXGGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268308AbUGXGGv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 02:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268309AbUGXGGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 02:06:51 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:56219 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268308AbUGXGGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 02:06:48 -0400
Subject: Re: [FC1], 2.6.8-rc2 kernel, new motherboard problems
From: Lee Revell <rlrevell@joe-job.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200407240158.56434.gene.heskett@verizon.net>
References: <Pine.LNX.4.44.0407211334260.3000-100000@mail.birdvet.org>
	 <20040722184938.GA5232@hobbes.itsari.int>
	 <1090630549.1471.17.camel@mindpipe>
	 <200407240158.56434.gene.heskett@verizon.net>
Content-Type: text/plain
Message-Id: <1090649207.1006.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Jul 2004 02:06:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-24 at 01:58, Gene Heskett wrote:
> On Friday 23 July 2004 20:55, Lee Revell wrote:
> >On Thu, 2004-07-22 at 14:49, Nuno Monteiro wrote:
> >> On 2004.07.22 13:49, Gene Heskett wrote:
> >> > 00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
> >> > Controller (rev a1)
> >> >         Subsystem: Biostar Microtech Int'l Corp: Unknown device
> >> > 2301
> >> >
> >> > However, this, nor the xconfig helps, still don't indicate which
> >> > driver I should be using, or where to get it if its not in the
> >> > kernel's tree yet a/o 2.6.8-rc2.  So thats the next piece of
> >> > data I need.
> >>
> >> Hi Gene,
> >>
> >>
> >> I believe you'll need forcedeth.c for this one. It's called
> >> "Reverse Engineered nForce Ethernet support", under Device Driver
> >> -> Networking -> Ethernet 10/100 Mbit.
> >
> >Wow, nVidia won't release the specs for a *10/100 ethernet
> > controller*? Having to reverse engineer a network driver is
> > ridiculous in this day and age.  I can understand binary-only
> > graphics drivers, there is a lot of valuable IP in there, but this
> > is a freaking network card.  What do they expect people to do?
> >
> >Maybe some bad press would set them straight.
> >
> >Lee
> 
> Nvidia is immune to bad press, and probably cannot release a thing 
> other than some API help due to copyright contracts with the coders 
> who wrote their winderz drivers for them,  The only cure would be for 
> them to hired a couple of dozen programmers of the minimum quality 
> the open source programmers exhibit, which I happen to think is top 
> notch, and the CEO can only see outgo without compensatory income for 
> all that salary, so they contract it out for a known cost, and get 
> tied up in restrictive contracts.
> 

I am not talking about them releasing driver code, I am just talking
about datasheets so we can write our own driver, something that tells
you which bits to write to which registers to get it to do $FOO.

Their net cost: $0.

Lee



