Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVCDFuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVCDFuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVCDFuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 00:50:23 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:54299 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S261379AbVCDFuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 00:50:17 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="3.90,134,1107734400"; 
   d="scan'208"; a="231299439:sNHT91939692"
Message-Id: <200503040550.AWZ06413@mira-sjc5-e.cisco.com>
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Andrew Morton'" <akpm@osdl.org>,
       "'Jochen Striepe'" <jochen@tolot.escape.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: RFD: Kernel release numbering
Date: Thu, 3 Mar 2005 21:50:06 -0800
Organization: Cisco Systems
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <20050303213005.59a30ae6.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Thread-Index: AcUgfKENILBaSA7/QaKhETHsmn/KWAAAHXfA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You cannot have it both ways.  Either the kernel needs 
> testers, or it is "stable".  See how these are opposites?

I think one of the fundamental problems is "either the kernel needs more
features, or it needs stablization". You cannot have it both ways. With the
current model, the kernel develops at a faster pace than testers can keep up
with, and that's why you feel there aren't enough testers.

Not everyone downloads a kernel every day or even every week. Just once a
while. If you roll out a kernel, you need to give some time to people to
test it out. However, with the current model the kernel keeps adding
features, non-bug fixes, etc, _and completely abandons the previous one and
moves on_. So what's the point of testing? When I download 2.6.9, 2.6.11
might have come out. Even if bug reports do not become obosolete, they are
outpaced by new bugs.

Agreed we need a balance. The problem is the 2.6 focuses too much on
development than stablization. The old "stable release maintainer" model was
completely abandoned. Surely that was not an exciting job, but people need
it.

Hua

