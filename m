Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266841AbSLUI6k>; Sat, 21 Dec 2002 03:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266842AbSLUI6k>; Sat, 21 Dec 2002 03:58:40 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:32213 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S266841AbSLUI6j>; Sat, 21 Dec 2002 03:58:39 -0500
Date: Sat, 21 Dec 2002 10:06:42 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Reuben Farrelly <reuben-linux@reub.net>
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org, Robert Collins <robertc@squid-cache.org>
Subject: Re: 2.4.20-aa and LARGE Squid process -> SIGSEGV
Message-ID: <20021221090642.GD31070@charite.de>
Mail-Followup-To: Reuben Farrelly <reuben-linux@reub.net>,
	Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
	linux-kernel@vger.kernel.org,
	Robert Collins <robertc@squid-cache.org>
References: <20021221001334.GA7996@werewolf.able.es> <20021220114837.GC13591@charite.de> <20021220223754.GA10139@werewolf.able.es> <20021220225733.GE31070@charite.de> <20021221001334.GA7996@werewolf.able.es> <5.2.0.9.2.20021221191530.02ade850@tornado.reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.0.9.2.20021221191530.02ade850@tornado.reub.net>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Reuben Farrelly <reuben-linux@reub.net>:

> No, squid is not br0ken in this fashion.  If squid cannot be allocated 
> enough memory by the system, it logs a message and _dies_.  Relevant files 
> to look at in your squid source are squid/lib/util.c for xcalloc() and 
> xmalloc().

Why can't squid allocate more than 1GB on a system with 2GB RAM?
 
> Aside from this, if squid ever does get to the point of swapping, it is 
> misconfigured and your performance has just gone to hell anyway...  (see 
> the FAQ at www.squid-cache.org)

It's not swapping. That's the whole point. We have 2GB and can use at
most 1GB for Squid.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
Microsoft: "Where do you want to go today?"
Linux:     "Where do you want to be tomorrow?"
BSD:       "Are you guys coming, or what?"

