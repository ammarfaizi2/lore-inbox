Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275716AbSIUCJq>; Fri, 20 Sep 2002 22:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275752AbSIUCJq>; Fri, 20 Sep 2002 22:09:46 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:43616 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S275716AbSIUCJp>; Fri, 20 Sep 2002 22:09:45 -0400
Date: Fri, 20 Sep 2002 22:14:15 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200209210214.g8L2EFE18681@devserv.devel.redhat.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Linux Hardened Device Drivers Project
In-Reply-To: <mailman.1032570840.22498.linux-kernel2news@redhat.com>
References: <mailman.1032570840.22498.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Obvious this is a way for the telecom folks to get something for free that
> really should be paid for by funding the project with CASH.  Or funding
> (a) startup(s) related to generating such support.

Andre, if I read you right, you are articulating the following
idea: "Those guys collect drivers written by students and try
to run them in production. Of course, it cannot work. If paid
professionals wrote them, there would be no problem."

If this is what you are saying here, it is very misguided.
I had a chance to examine some of drivers written by paid
professionals, and the picture was pretty bleak. Also, the
problem of hardening is not unique to Linux or Open Source,
I had runs with it before.

So, I do not think there's a budgetary issue here. I talked to
the C-G Linux folks at OLS, and they do have funding. But I do
not think the hardening is going to fly the way they push it,
for two technical reasons.

 First, you cannot race crappy driver writers. As soon as you
harden and qualify something, technology changes and brings
a whole bunch of crappy drivers.

 Second, the resulting "hardened" system is no less fragile than
it was before.

If I was going the C-G Linux, I would abandon the "hardening"
efforts as they are now, and shift in-house hackers to work on
clusters and UML (including a cluster or UMLs).

As far as giving goes, the C-G people expended a lot of effort
on documentation of their wishes (again, judging by their OLS
performance). And I mean *A F. LOT* of effort. If they
coded as much as they wrote reports and reviews, we'd probably
have something working by now.

-- Pete
