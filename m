Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbULFPbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbULFPbA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 10:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbULFPbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 10:31:00 -0500
Received: from jade.aracnet.com ([216.99.193.136]:55467 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261539AbULFP3B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 10:29:01 -0500
Date: Mon, 06 Dec 2004 07:28:51 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alexander Nyberg <alexn@dsv.su.se>, linux-kernel@vger.kernel.org
cc: zwane@holomorphy.com, akpm@osdl.org
Subject: Re: The bugzilla story
Message-ID: <476570000.1102346931@[10.10.2.4]>
In-Reply-To: <1102342960.727.59.camel@boxen>
References: <1102342960.727.59.camel@boxen>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As some of you may have noticed I've been doing a run on bugzilla for
> the last few days to close old bugs and upgrade those who still are real
> bugs.
> 
> I have a few things that I would like to enforce on bugzilla to makes it
> more maintanable which it clearly hasn't been for a while - there are
> lots and lots of bugs open older than 2.6.0-final.
> 
> I think the alternative trees section should be dropped. This is
> especially a matter for -mm which has most reports of the alternative
> trees in bugzilla. -mm changes way too rapidly to keep track of at
> bugzilla ending up with open bugs that are fixed long ago.
> 
> I also think this goes for any alternative tree, that problems should be
> reported directly to the maintainer/LKML of the tree. Only if a problem
> can be reproduced with the mainline kernel should the bug be reported at
> bugzilla. 
> 
> New bugzilla reports against other trees than mainline should be
> rejected and ask the submitter to report directly to the
> maintainer/LKML.
> 
> Andrew, what do you think about bug reports against -mm on bugzilla?
> 
> Does anyone see a problem with this? 

The subtrees section was created for exactly that reason - to isolate the
bugs in alternate trees, and keep the out of everyone else's hair. Now if
one was to argue that bugs in -mm should be cleaned up much more agressively,
that'd make a lot of sense ... but that should be fairly easy to do as 
they're in a separate category you can search by.

The main issue is that there haven't been many people doing what you're doing
now ... going through and housekeeping the bugs.

M.

