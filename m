Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbULFOYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbULFOYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 09:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbULFOYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 09:24:45 -0500
Received: from mailfe07.swip.net ([212.247.154.193]:25237 "EHLO
	mailfe07.swip.net") by vger.kernel.org with ESMTP id S261527AbULFOWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 09:22:50 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: The bugzilla story
From: Alexander Nyberg <alexn@dsv.su.se>
To: linux-kernel@vger.kernel.org
Cc: zwane@holomorphy.com, akpm@osdl.org
Content-Type: text/plain
Date: Mon, 06 Dec 2004 15:22:40 +0100
Message-Id: <1102342960.727.59.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

As some of you may have noticed I've been doing a run on bugzilla for
the last few days to close old bugs and upgrade those who still are real
bugs.

I have a few things that I would like to enforce on bugzilla to makes it
more maintanable which it clearly hasn't been for a while - there are
lots and lots of bugs open older than 2.6.0-final.

I think the alternative trees section should be dropped. This is
especially a matter for -mm which has most reports of the alternative
trees in bugzilla. -mm changes way too rapidly to keep track of at
bugzilla ending up with open bugs that are fixed long ago.

I also think this goes for any alternative tree, that problems should be
reported directly to the maintainer/LKML of the tree. Only if a problem
can be reproduced with the mainline kernel should the bug be reported at
bugzilla. 

New bugzilla reports against other trees than mainline should be
rejected and ask the submitter to report directly to the
maintainer/LKML.

Andrew, what do you think about bug reports against -mm on bugzilla?

Does anyone see a problem with this? 

Thanks
Alexander

