Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSHIPpn>; Fri, 9 Aug 2002 11:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSHIPpn>; Fri, 9 Aug 2002 11:45:43 -0400
Received: from bitmover.com ([192.132.92.2]:52406 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S314138AbSHIPpm>;
	Fri, 9 Aug 2002 11:45:42 -0400
Date: Fri, 9 Aug 2002 08:49:16 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Paul Larson <plars@austin.ibm.com>, Jeff Garzik <jgarzik@mandrakesoft.com>,
       Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Announce: daily 2.5 BK snapshots
Message-ID: <20020809084916.E14025@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Paul Larson <plars@austin.ibm.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1028903778.19435.348.camel@plars.austin.ibm.com> <1505209847.1028881191@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1505209847.1028881191@[10.10.2.3]>; from Martin.Bligh@us.ibm.com on Fri, Aug 09, 2002 at 08:19:53AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Personally, I'd love to see the *changes* in what passed and failed
> posted every day - the whole result set is obviously too big. The 
> quicker people know what's wrong, the quicker it gets fixed, before
> we build more on top of an unstable foundation.

I really like "fix it before we build on an unstable foundation".

It seems to me that we could get to something like tinderbox (? One of the
mozilla tools).  What I'm imagining is something like a web page which
has a set of links in which point at the csets which cause the problem.
In order to make this work, we need to fix BK/Web to talk URLs with
"keys" instead of revs because, as some of you have noticed, revs change
when there is parallel development which makes the URLs pretty useless
if they contain revs.

If you need that fix in order to be able to have a list of URLs pointing
int BK/Web on bkbits.net, bug me about it, we'll do it right away.
I like the idea of having a status page which says "these changesets
cause problems".  You can have two links, one which gets you to the BK
cset html and the other which gets the patch corresponding to the cset.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
