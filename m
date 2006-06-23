Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752039AbWFWUet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbWFWUet (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbWFWUet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:34:49 -0400
Received: from web33311.mail.mud.yahoo.com ([68.142.206.126]:1183 "HELO
	web33311.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752039AbWFWUes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:34:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4C1z4qDQbJ8yH3eU3/ZrwtncTWDH5x1A3Hofk/JEqr8mYPiqPL9s8AI/00b3rwfMvCELbJknqwVKyp1nAZdFxASTZMEqK/I3WDKtohoTzFH3TCWJQsD6spWHb4hYRB1AeyuJCW5VnvuR6Yx2nQUxGyC1ulHP0BpVe4nbF2CIlW4=  ;
Message-ID: <20060623203447.60105.qmail@web33311.mail.mud.yahoo.com>
Date: Fri, 23 Jun 2006 13:34:47 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: Measuring tools - top and interrupts
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060622235356.GA31168@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Francois Romieu <romieu@fr.zoreil.com> wrote:

> Danial Thom <danial_thom@yahoo.com> :
> [...]
> > systat". Plus its clear that the guy who gave
> the
> > answer doesn't know what he's talking about,
> > since he's actually trying to explain away
> the
> > problem as being normal. 
> 
> "75 kpps means 10% of the max load" was quite
> fun too.
> 

What's *fun* about it? 2.4.24 shows a 12-13%
load. 

> [...]
> > the system is perpetually 100% idle but its
> > dropping packets due to excessive backlog.
> 
> No difference when you renice ksoftirqd to a
> strongly
> negative value ?

No, not really. Running the compiler causes
drops. re-nicing eliminates drops with no
userland activity.

DT

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
