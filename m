Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWDUMOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWDUMOQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 08:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWDUMOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 08:14:16 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:58011 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932133AbWDUMOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 08:14:15 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20060420192717.GA3828@sorel.sous-sol.org>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <1145470463.3085.86.camel@laptopd505.fenrus.org>
	 <p73mzeh2o38.fsf@bragg.suse.de>
	 <1145522524.3023.12.camel@laptopd505.fenrus.org>
	 <20060420192717.GA3828@sorel.sous-sol.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 21 Apr 2006 08:18:46 -0400
Message-Id: <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 12:27 -0700, Chris Wright wrote:
> * Arjan van de Ven (arjan@infradead.org) wrote:
> > On Thu, 2006-04-20 at 00:32 +0200, Andi Kleen wrote:
> > > Arjan van de Ven <arjan@infradead.org> writes:
> > > > 
> > > > you must have a good defense against that argument, so I'm curious to
> > > > hear what it is
> > > 
> > > [I'm not from the apparmor people but my understanding is]
> > > 
> > > Usually they claimed name spaces as the reason it couldn't work.
> > 
> > I actually posted a list of 10 things that I made up in 3 minutes; just
> > going over those 10 would be a good start already since they're the most
> > obvious ones..
> 
> Yes, the conversation is all over the place.  Many of the issues are
> about some of the uglier parts of the AppArmor code, but the critical
> issue is simple.  Does their protection model actually protect against
> their threat model.  I would really like to see some grounded examples
> that show whether it's broken or not.

Difficult to evaluate, when the answer whenever a flaw is pointed out is
"that's not in our threat model."  Easy enough to have a protection
model match the threat model when the threat model is highly limited
(and never really documented anywhere, particularly in a way that might
warn its users of its limitations).

-- 
Stephen Smalley
National Security Agency

