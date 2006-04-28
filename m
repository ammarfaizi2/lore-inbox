Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965212AbWD1Lrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965212AbWD1Lrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 07:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbWD1Lrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 07:47:42 -0400
Received: from mx1.suse.de ([195.135.220.2]:47311 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965209AbWD1Lrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 07:47:41 -0400
From: Andi Kleen <ak@suse.de>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Date: Fri, 28 Apr 2006 13:47:27 +0200
User-Agent: KMail/1.9.1
Cc: Ken Brush <kbrush@gmail.com>, Neil Brown <neilb@suse.de>,
       Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <ef88c0e00604271058q203d0553sf45401914a892799@mail.gmail.com> <1146223713.11817.7.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1146223713.11817.7.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604281347.28185.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 April 2006 13:28, Stephen Smalley wrote:

> So you are only worried about script kiddies?  Further, once someone
> crafts an exploit specifically targeting AA, knowing full well its
> limitations, that exploit will become fodder for the kiddies as well.
> If a security mechanism only prevents attacks that weren't designed
> against it, what good is it aside from a temporary stopgap?

The same could be said about selinux. Or what are you doing
to e.g. stop DOS attacks? Nothing is 100% water tight. The question
is just if the subsets of controls it implements matches the requirements of 
the administrator. These requirements both include easiness of use
and security. Usually there is a tradeoff there and it's not the
same for everybody.

> > I have no requirements like that. I just would prefer that when people
> > try to exploit my internet services, that the programs are not allowed
> > to do things that I would rather it not do. AA seems to fulfill that
> > requirement.
> 
> Why can't you use existing virtualization solutions ala Vservers or
> OpenVZ or whatever?

I guess he doesn't want to administrate a "cluster" of machines with many
/s, just a single box.

-Andi
