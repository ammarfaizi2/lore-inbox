Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbUD2BvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUD2BvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUD2BvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:51:09 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:58635 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S262873AbUD2BvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:51:03 -0400
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1083203296@astro.swin.edu.au>
Subject: Re:  ~500 megs cached yet 2.6.5 goes into swap hell
In-reply-to: <4090524C.3020509@yahoo.com.au>
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40904A84.2030307@yahoo.com.au> <20040428205059.A4563@animx.eu.org> <4090524C.3020509@yahoo.com.au>
X-Face: "0\RuOFb6AcQ}B_F/^%;;AmS%><zZ_q?N1w1%1voDY7#Ywj~qRaL7].8HB'2~pDUS|{E=$R\-s?;+p!RCe:w||kS\T@[(eQHB*-8u;~)ZP4;QYUI`|GJ)NS\`jLbW<e'R*y+Od,S5D+Vz++a<[$g'>"qr*^0t%eriBMe_x]B7&@b8_\i<A/A@T
Message-ID: <slrn-0.9.7.4-18522-12106-200404291148-tc@hexane.ssi.swin.edu.au>
Date: Thu, 29 Apr 2004 11:51:01 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> said on Thu, 29 Apr 2004 10:54:36 +1000:
> Wakko Warner wrote:
> >>I don't know. What if you have some huge application that only
> >>runs once per day for 10 minutes? Do you want it to be consuming
> >>100MB of your memory for the other 23 hours and 50 minutes for
> >>no good reason?
> > 
> > 
> > I keep soffice open all the time.  The box in question has 512mb of ram. 
> > This is one app, even though I use it infrequently, would prefer that it
> > never be swapped out.  Mainly when I want to use it, I *WANT* it now (ie not
> > waiting for it to come back from swap)
> > 
> > This is just my oppinion.  I personally feel that cache should use available
> > memory, not already used memory (swapping apps out for more cache).
> > 
> 
> On the other hand, suppose that with soffice resident the entire
> time, you don't have enough memory to cache an entire kernel tree
> (or video you are editing, or whatever).

For the kernel example, I only ever compile once before rebooting[1]
:)

This I think is the kind of thing that a kernel will never
automatically detect. This *must* be in the hands of the
administrator, who will know what they are doing (hopefully).

[1] I have never had enough memory on machines that I use to compile
kernels, to cache an entire tree anyway -- I'd much rather mozilla use
it than a cache which will never be reused

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
[transporting bed]... across several suburbs and a large salt water
harbour. Well, they thoughtfully bridged the harbour in the 1930s, so
the problem was actually transporting it across several suburbs and a
long single span bridge.          -- Hipatia
