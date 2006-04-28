Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbWD1M5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWD1M5o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 08:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWD1M5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 08:57:44 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:65447 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1030379AbWD1M5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 08:57:43 -0400
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11]
	security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Karl MacMillan <kmacmillan@tresys.com>, Andi Kleen <ak@suse.de>,
       Ken Brush <kbrush@gmail.com>, Neil Brown <neilb@suse.de>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <20060427234437.GG2909@sorel.sous-sol.org>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <17487.61698.879132.891619@cse.unsw.edu.au>
	 <ef88c0e00604261606g64ed5844j67890e8c3d7974a9@mail.gmail.com>
	 <200604270615.20554.ak@suse.de> <20060427101734.GH3026@sorel.sous-sol.org>
	 <1146148924.2759.49.camel@jackjack.columbia.tresys.com>
	 <20060427234437.GG2909@sorel.sous-sol.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 28 Apr 2006 09:02:08 -0400
Message-Id: <1146229328.11817.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 16:44 -0700, Chris Wright wrote:
> * Karl MacMillan (kmacmillan@tresys.com) wrote:
> > While this is example of labeling issues with SELinux is correct for a
> > standard targeted policy, it does not represent an intrinsic problem
> > with the SELinux mechanism. A policy that has the appropriate
> > specialized domains for reading /etc/shadow and corresponding
> > type_transition rules can prevent this mislabeling. The solution may not
> > be very satisfying because of the changes it makes to how systems are
> > typically administered, but at least it does exist within the SELinux
> > model. The same cannot be said of the problems introduced by path-based
> > mechanisms.
> 
> Indeed, I tried to be quite specific to targeted policy.  The point
> is that having unconfined domains makes it very challenging to reason
> about the security of the system.  So, while comprehensive strict policy
> addresses that, it's also what nearly guarantees turning security off
> for most normal general purpose machines ;-)

But this is a temporary situation, until we have the infrastructure and
tools developed to make MAC truly manageable by typical end users.  Not
an inherent problem.

-- 
Stephen Smalley
National Security Agency

