Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264131AbUDRFgB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 01:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbUDRFgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 01:36:01 -0400
Received: from florence.buici.com ([206.124.142.26]:45440 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264131AbUDRFfz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 01:35:55 -0400
Date: Sat, 17 Apr 2004 22:35:54 -0700
From: Marc Singer <elf@buici.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Marc Singer <elf@buici.com>, William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-ID: <20040418053553.GB19595@flea>
References: <20040417212958.GA8722@flea> <20040417162125.3296430a.akpm@osdl.org> <20040417233037.GA15576@flea> <20040417165151.24b1fed5.akpm@osdl.org> <20040418002343.GA16025@flea> <4081F809.4030606@yahoo.com.au> <20040418041748.GW743@holomorphy.com> <408206E8.5000600@yahoo.com.au> <20040418051024.GA19595@flea> <40820FFF.8090906@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40820FFF.8090906@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 03:19:59PM +1000, Nick Piggin wrote:
> >>Well, here is the current patch against 2.6.5-mm6. -mm is
> >>different enough from -linus now that it is not 100% trivial
> >>to patch (mainly the rmap and hugepages work).
> >
> >
> >Will this work against 2.6.5 without -mm6?
> >
> 
> Unfortunately it won't patch easily. If this is a big
> problem for you I could make you up a 2.6.5 version.

We'll, I'll try applying his patch and then yours.  If it doesn't work
I'll let you know.

> 
> >As an aside, I've been using SVN to manage my kernel sources.  While
> >I'd be thrilled to make it work, it simply doesn't seem to have the
> >heavy lifting capability to handle the kernel work.  I know the
> >rudiments of using BK.  What I'd like is some sort of HOWTO with
> >example of common tasks for kernel development.  Know of any?
> >
> 
> Well I don't do a great deal of coding or merging, but I
> use Andrew Morton's patch scripts which make things very
> easy for me.

Where does he keep 'em.

> Regarding bitkeeper, I have never tried it but there is
> some help in Documentation/BK-usage/ which might be of
> use to you.

I'll read it.  Thanks.

