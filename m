Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTLHT5D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 14:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTLHT5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 14:57:03 -0500
Received: from ca1.symonds.net ([66.92.42.136]:26295 "EHLO symonds.net")
	by vger.kernel.org with ESMTP id S262040AbTLHT4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 14:56:38 -0500
Message-ID: <022e01c3bdc5$651137a0$7a01a8c0@gandalf>
From: "Mark Symonds" <mark@symonds.net>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Harald Welte" <laforge@netfilter.org>
References: <Pine.LNX.4.44.0312080815460.30140-100000@logos.cnet>
Subject: Re: 2.4.23 hard lock, 100% reproducible.
Date: Mon, 8 Dec 2003 11:56:39 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> > I'm using ipchains compatability in there, looks like 
> > this is a possible cause - getting a patch right now,
> > will test and let y'all know (and then switch to 
> > iptables, finally). 
> 
> Mark,
> 
> Please try the latest BK tree. There was a known bug in the netfilter code 
> which could cause the lockups. 
> 

What I did a couple of days ago was remove ipchains and switch 
to iptables (instead of applying any patches or anything).  Ever 
since the ipchains code was removed from my kernel, the box has 
been running fine.

Thanks much! 

-- 
Mark
 
