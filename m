Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbVLVR2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbVLVR2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 12:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbVLVR2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 12:28:54 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:36081 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1030218AbVLVR2x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 12:28:53 -0500
Subject: Re: [PATCH 02/02] RT: plist namespace cleanup
From: Daniel Walker <dwalker@mvista.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, inaky.perez-gonzalez@intel.com,
       tglx@linutronix.de, mingo@elte.hu
In-Reply-To: <43AAEF6E.47CCEFE0@tv-sign.ru>
References: <1135202230.22970.15.camel@localhost.localdomain>
	 <43AAB3C8.DB304856@tv-sign.ru>
	 <1135270381.3696.2.camel@localhost.localdomain>
	 <43AAEF6E.47CCEFE0@tv-sign.ru>
Content-Type: text/plain
Date: Thu, 22 Dec 2005 09:28:51 -0800
Message-Id: <1135272531.3696.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 21:24 +0300, Oleg Nesterov wrote:
> Daniel Walker wrote:
> > 
> > On Thu, 2005-12-22 at 17:10 +0300, Oleg Nesterov wrote:
> > > Daniel Walker wrote:
> > > >
> > > >         Make the plist namespace consistent.
> > >
> > > I think plist_head is much better than pl_head.
> > >
> > > However I think plist_empty/plist_unhashed is more accurate
> > > than plist_head_empty/plist_node_empty, but I am rather
> > > agnostic to naming.
> > 
> > unhashed seems very meaningless . We're not hashing anything.
> 
> Still we already have hlist_empty/hlist_unhashed

That's more connected with hashing , since that's were it gets used. In
this case we're not hashing , or even related to hashing. 

> > > Daniel, it would be great if you can check that kernel/rt.o
> > > was not changed after rename (as it should be).
> > 
> > I didn't check, but I made no code changes so it should be any
> > different.
> 
> That is why I asked. It is very easy to make a mistake by accident
> while doing trivial changes, but it is not easy to notice.

I reviewed it prior to submitting it . 

Daniel

