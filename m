Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263883AbTIBVzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 17:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263888AbTIBVzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 17:55:37 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:2234 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S263883AbTIBVzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 17:55:33 -0400
Date: Tue, 2 Sep 2003 17:52:29 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Florian Weimer <fw@deneb.enyo.de>
cc: Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
In-Reply-To: <87llt9bvtc.fsf@deneb.enyo.de>
Message-ID: <Pine.GSO.4.33.0309021744290.13584-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Aug 2003, Florian Weimer wrote:
>The ISP can do several things to prioritize production traffic or drop
>malicious traffic.  However, this isn't trivial and requires careful
>planning, and it's unlikely that anyone who is able to would want to
>do this for a T1 customer (typically, it requires "unusual"
>configuration of vital production routers with the fat pipes).

In the cisco world, all it takes is:
	interface <foo>
	  fair-queue

That's it.  That's all it takes on the ISPs part to provide a minimal
amount of QoS.  Cisco's documentation clearly lists how IOS handles
the queuing.  It's not full policy based traffic shaping with RSVP
and all that crap, but it's enough for a many situations.

Larry's situation is highly complicated by "the internet".  I've never
known anyone to be happy with VoIP across the internet.  It's hard
enough to make it work properly within a single ISP's network _with_
their assistance.  Across the wastelands, forget about it. (Why do you
think GRIC built their own global network for moving VoIP traffic?)

--Ricky


