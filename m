Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWDUAPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWDUAPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWDUAPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:15:51 -0400
Received: from cantor2.suse.de ([195.135.220.15]:8612 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932164AbWDUAPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:15:50 -0400
Date: Thu, 20 Apr 2006 17:11:16 -0700
From: Tony Jones <tonyj@suse.de>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: grundig <grundig@teleline.es>, Crispin Cowan <crispin@novell.com>,
       ak@suse.de, arjan@infradead.org, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060421001116.GA8093@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <p73mzeh2o38.fsf@bragg.suse.de> <20060420011037.6b2c5891.grundig@teleline.es> <200604200138.00857.ak@suse.de> <4446E4AE.1090901@novell.com> <20060420150001.25eafba0.grundig@teleline.es> <20060420130917.GF18604@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420130917.GF18604@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 08:09:17AM -0500, Serge E. Hallyn wrote:
> Quoting grundig (grundig@teleline.es):
> > El Wed, 19 Apr 2006 18:32:30 -0700,
> > Crispin Cowan <crispin@novell.com> escribi?:
> > 
> > > Our controls on changing the name space have rather poor granularity at
> > > the moment. We hope to improve that over time, and especially if LSM
> > > evolves to permit it. This is ok, because as Andi pointed out, there are
> > > currently few applications using name spaces, so we have time to improve
> > > the granularity.
> > 
> > Wouldn't have more sense to improve it and then submit it instead of the
> > contrary? At least is the rule which AFAIK is applied to every feature 
> > going in the kernel, specially when there's an available alternative
> > which users can use meanwhile (see reiser4...)
> 
> hah, that's funny
> 
> When people do that, they are rebuked for not submitting upstream.  At
> least this way, we can have a discussion about whether the approach
> makes sense at all.

When an out of tree user is requesting a change for which it will likely be 
the only user (such that it can make it in tree), caution is warranted.  But 
it does create a bit of a chicken and egg conundrum for the proposer.  

At least this is the way it's always seemed to me (re: the requested VFS/LSM
changes). Anyways, it's not an issue and there isn't a lot of point dwelling
over past LSM history. I 100% agree with Serge, discussion first about the 
approach is definately the way to go.

Tony
