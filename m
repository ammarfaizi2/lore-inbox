Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbSLHPz4>; Sun, 8 Dec 2002 10:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSLHPz4>; Sun, 8 Dec 2002 10:55:56 -0500
Received: from mail.ithnet.com ([217.64.64.8]:28170 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S261337AbSLHPzz>;
	Sun, 8 Dec 2002 10:55:55 -0500
Date: Sun, 8 Dec 2002 17:03:36 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: willy@w.ods.org, linux-kernel@vger.kernel.org
Subject: Re: hidden interface (ARP) 2.4.20
Message-Id: <20021208170336.5f4deaf1.skraw@ithnet.com>
In-Reply-To: <3DF2848F.2010900@drugphish.ch>
References: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil>
	<1039124530.18881.0.camel@rth.ninka.net>
	<20021205140349.A5998@ns1.theoesters.com>
	<3DEFD845.1000600@drugphish.ch>
	<20021205154822.A6762@ns1.theoesters.com>
	<3DF2848F.2010900@drugphish.ch>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Dec 2002 00:30:23 +0100
Roberto Nibali <ratz@drugphish.ch> wrote:

> Hello,
> 
> [Maybe we should discuss this in private, it doesn't have a lot to do 
> with kernel development anymore.]

To be honest: I think this _is_ indeed a kernel development issue. We are
somehow talking of a performance lack that can be overcome by a simple patch
(call it hack) and some brain.

> > Because when you have to deal with thousands of session per second, NAT is
> > really a pain in the ass. When you have to consider security, NAT is a pain
> 
> Not with a HW LB, and with a SW LB (LVS-NAT) you can very well sustain 
> 20000 NAT'd load balanced connections with 5 minutes of stickyness 
> (persistency) with 1GB RAM and a PIII Tualatin with 512 kb L2 cache. I'm 
> not sure if you meant this when mentioning pain.

I guess he probably meant a _bit_ more. I may add some zeros to your 20000 to
give you a glimpse of a _standard_ load we are talking about. And you can
easily do this with the hardware you mentioned _not_ using NAT (of course ;-).

I guess it would really be a great help if someone did tests like Cons'
"overall performance" ones for network performance explicitly. Like e.g.
performance for various packet-sizes of all available protocol types, possibly
including NAT connections. We have no comparable figures at hand right now, I
guess.

-- 
Regards,
Stephan

