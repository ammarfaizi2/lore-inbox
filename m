Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbULFQ07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbULFQ07 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 11:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbULFQ07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 11:26:59 -0500
Received: from mailfe06.swip.net ([212.247.154.161]:54526 "EHLO
	mailfe06.swip.net") by vger.kernel.org with ESMTP id S261555AbULFQ04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 11:26:56 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: Re: The bugzilla story
From: Alexander Nyberg <alexn@dsv.su.se>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, zwane@holomorphy.com, akpm@osdl.org
In-Reply-To: <476570000.1102346931@[10.10.2.4]>
References: <1102342960.727.59.camel@boxen>
	 <476570000.1102346931@[10.10.2.4]>
Content-Type: text/plain
Date: Mon, 06 Dec 2004 17:26:45 +0100
Message-Id: <1102350405.727.79.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-06 at 07:28 -0800, Martin J. Bligh wrote:
> > As some of you may have noticed I've been doing a run on bugzilla for
> > the last few days to close old bugs and upgrade those who still are real
> > bugs.
> > 
> > I have a few things that I would like to enforce on bugzilla to makes it
> > more maintanable which it clearly hasn't been for a while - there are
> > lots and lots of bugs open older than 2.6.0-final.
> > 
> > I think the alternative trees section should be dropped. This is
> > especially a matter for -mm which has most reports of the alternative
> > trees in bugzilla. -mm changes way too rapidly to keep track of at
> > bugzilla ending up with open bugs that are fixed long ago.
> > 
> > I also think this goes for any alternative tree, that problems should be
> > reported directly to the maintainer/LKML of the tree. Only if a problem
> > can be reproduced with the mainline kernel should the bug be reported at
> > bugzilla. 
> > 
> > New bugzilla reports against other trees than mainline should be
> > rejected and ask the submitter to report directly to the
> > maintainer/LKML.
> > 
> > Andrew, what do you think about bug reports against -mm on bugzilla?
> > 
> > Does anyone see a problem with this? 
> 
> The subtrees section was created for exactly that reason - to isolate the
> bugs in alternate trees, and keep the out of everyone else's hair. Now if
> one was to argue that bugs in -mm should be cleaned up much more agressively,
> that'd make a lot of sense ... but that should be fairly easy to do as 
> they're in a separate category you can search by.
> 
> The main issue is that there haven't been many people doing what you're doing
> now ... going through and housekeeping the bugs.

The thing is that -mm changes so fast that a bug reported can be solved
an hour later, leaving a stale bug report for a few days (or years).
Whoever wants to pick up the bug quite much has to mail either the
bug-submitter asking if the bug has been resolved, mail the maintainer
of whatever area the bug concerns or mail akpm. 

This leads me to thinking that bugzilla doesn't serve any functionality
for at least -mm.

Alexander


