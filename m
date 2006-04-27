Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751659AbWD0XpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWD0XpJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 19:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbWD0XpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 19:45:09 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:8578 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751659AbWD0XpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 19:45:07 -0400
Date: Thu, 27 Apr 2006 16:44:37 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@suse.de>,
       Ken Brush <kbrush@gmail.com>, Neil Brown <neilb@suse.de>,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060427234437.GG2909@sorel.sous-sol.org>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <17487.61698.879132.891619@cse.unsw.edu.au> <ef88c0e00604261606g64ed5844j67890e8c3d7974a9@mail.gmail.com> <200604270615.20554.ak@suse.de> <20060427101734.GH3026@sorel.sous-sol.org> <1146148924.2759.49.camel@jackjack.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146148924.2759.49.camel@jackjack.columbia.tresys.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Karl MacMillan (kmacmillan@tresys.com) wrote:
> While this is example of labeling issues with SELinux is correct for a
> standard targeted policy, it does not represent an intrinsic problem
> with the SELinux mechanism. A policy that has the appropriate
> specialized domains for reading /etc/shadow and corresponding
> type_transition rules can prevent this mislabeling. The solution may not
> be very satisfying because of the changes it makes to how systems are
> typically administered, but at least it does exist within the SELinux
> model. The same cannot be said of the problems introduced by path-based
> mechanisms.

Indeed, I tried to be quite specific to targeted policy.  The point
is that having unconfined domains makes it very challenging to reason
about the security of the system.  So, while comprehensive strict policy
addresses that, it's also what nearly guarantees turning security off
for most normal general purpose machines ;-)

thanks,
-chris
