Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275221AbTHRWum (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 18:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275229AbTHRWum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 18:50:42 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:51392
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S275221AbTHRWul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 18:50:41 -0400
Date: Tue, 19 Aug 2003 00:31:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: green@namesys.com, marcelo@conectiva.com.br, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030818223127.GH16139@dualathlon.random>
References: <20030813125509.360c58fb.skraw@ithnet.com> <Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain> <20030813145940.GC26998@namesys.com> <20030813171224.2a13b97f.skraw@ithnet.com> <20030813153009.GA27209@namesys.com> <20030818150625.GW7862@dualathlon.random> <20030818221921.7b96de86.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818221921.7b96de86.skraw@ithnet.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 10:19:21PM +0200, Stephan von Krawczynski wrote:
> On Mon, 18 Aug 2003 17:06:25 +0200
> Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > an SMP kernel puts the double of the stress on the mem bus, so it might
> > still be ram that went bad around the time you upgraded from 2.4.19. Or
> > it maybe simply a buggy smp motherboard, or whatever.
> > 
> > Of course I can't be sure but we can't exclude it.
> 
> It is unlikely for bad ram to survive memtest for several hours.

memtest is single threaded, UP kernel works fine too.

Andrea
