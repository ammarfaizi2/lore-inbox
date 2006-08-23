Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWHWHny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWHWHny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 03:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWHWHnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 03:43:53 -0400
Received: from nf-out-f131.google.com ([64.233.182.131]:63662 "EHLO
	nf-out-f131.google.com") by vger.kernel.org with ESMTP
	id S932373AbWHWHnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 03:43:53 -0400
Message-ID: <5640c7e00608230043h17d330c0ka46de63cfb5bf7de@mail.gmail.com>
Date: Wed, 23 Aug 2006 19:43:50 +1200
From: "Ian McDonald" <ian.mcdonald@jandi.co.nz>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Cc: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
       "Jari Sundell" <sundell.software@gmail.com>,
       "David Miller" <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
       nmiell@comcast.net, linux-kernel@vger.kernel.org, drepper@redhat.com,
       netdev@vger.kernel.org, zach.brown@oracle.com, hch@infradead.org
In-Reply-To: <20060823000758.5ebed7dd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b3f268590608221551q5e6a1057hd1474ee8b9811f10@mail.gmail.com>
	 <20060822231129.GA18296@ms2.inr.ac.ru>
	 <b3f268590608221728r6cffd03i2f2dd12421b9f37@mail.gmail.com>
	 <20060822.173200.126578369.davem@davemloft.net>
	 <b3f268590608221743o493080d0t41349bc4336bdd0b@mail.gmail.com>
	 <20060823065659.GC24787@2ka.mipt.ru>
	 <20060823000758.5ebed7dd.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder whether designing-in a millisecond granularity is the right thing
> to do.  If in a few years the kernel is running tickless with high-res clock
> interrupt sources, that might look a bit lumpy.
>
I'd second that - when working on DCCP I've done a lot of the work in
microseconds and it made quite a difference instead of milliseconds
because of it's design.

I haven't followed kevents in great detail but it sounds like
something that could be useful for me with higher resolution timers
than milliseconds.
-- 
Ian McDonald
Web: http://wand.net.nz/~iam4
Blog: http://imcdnzl.blogspot.com
WAND Network Research Group
Department of Computer Science
University of Waikato
New Zealand
