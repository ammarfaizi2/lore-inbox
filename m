Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVCCHDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVCCHDq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 02:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVCCHAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 02:00:49 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:38995 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S261179AbVCCG4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 01:56:06 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="3.90,132,1107734400"; 
   d="scan'208"; a="230976334:sNHT21442634"
Message-Id: <200503030655.AWY08157@mira-sjc5-e.cisco.com>
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: "'David S. Miller'" <davem@davemloft.net>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: RFD: Kernel release numbering
Date: Wed, 2 Mar 2005 22:55:53 -0800
Organization: Cisco Systems
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Thread-Index: AcUfo4+kAcfxmD6aSum8b3HwKxDfuQAAzHwg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And the reason it does _not_ work is that all the people we 
> want testing sure as _hell_ won't be testing -rc versions.

At least they still test "real" releases..

So instead of making sure rc is really "release-candidate", we want to trick
people to test -pre as "real release", soon people will realize it and just
stop testing even real releases. The trick won't last. What other names will
we try then? Seriously, this is silly and the focus is wrong, and will
accomplish nothing but confusing people one more time.

Let's start by making rc really "release-candidate", not something with
last-minute unpredictable random changes. Why should I test rc when I know
the final release will be much different anyway? What is worse is that we
actually _complain_ about the fact that people do not take rc seriously,
while the release management doesn't take it seriously itself.

Hua
