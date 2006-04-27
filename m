Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWD0HnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWD0HnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 03:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWD0HnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 03:43:14 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:32128 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932425AbWD0HnN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 03:43:13 -0400
Date: Thu, 27 Apr 2006 00:40:08 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, Ken Brush <kbrush@gmail.com>,
       Neil Brown <neilb@suse.de>, Stephen Smalley <sds@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060427074008.GE3026@sorel.sous-sol.org>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <17487.61698.879132.891619@cse.unsw.edu.au> <ef88c0e00604261606g64ed5844j67890e8c3d7974a9@mail.gmail.com> <200604270615.20554.ak@suse.de> <1146120771.2894.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146120771.2894.10.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven (arjan@infradead.org) wrote:
> On Thu, 2006-04-27 at 06:15 +0200, Andi Kleen wrote:
> > On Thursday 27 April 2006 01:06, Ken Brush wrote:
> > 
> > > > 2/ What advantages does AppArmor provide over techniques involving
> > > >    virtualisation or gaol mechanisms?  Are these advantages worth
> > > >    while?
> > 
> > I would guess the advantage is easier administration. e.g. I always
> > found it a PITA to synchronize files like /etc/resolv.conf and similar
> > files into chroots.
> 
> there's another option than just chroots; construct a namespace with
> just the allowed files bind-mounted in. That is 100% scriptable and also
> doesn't have the "stale files" problem

That doesn't support different access modes aside of DAC, which defeats
the point.  So either way, there's a need for better infrastructure.
