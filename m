Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVJJRP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVJJRP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbVJJRP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:15:57 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:30808
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1751062AbVJJRPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:15:38 -0400
Date: Mon, 10 Oct 2005 19:15:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Valdis.Kletnieks@vt.edu
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up
Message-ID: <20051010171525.GB13739@opteron.random>
References: <20050923153158.GA4548@x30.random> <1127509047.8880.4.camel@kleikamp.austin.ibm.com> <1127509155.8875.6.camel@kleikamp.austin.ibm.com> <1127511979.8875.11.camel@kleikamp.austin.ibm.com> <20050928223829.GH10408@opteron.random> <1128126424.10237.7.camel@kleikamp.austin.ibm.com> <20051002102726.GB26677@opteron.random> <1128261072.9382.4.camel@kleikamp.austin.ibm.com> <1128362768.8967.10.camel@kleikamp.austin.ibm.com> <200510031831.j93IVQJT019379@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510031831.j93IVQJT019379@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

So what's the status of this? Dave can you still reproduce hangs with
your last jfs fixes applied?

Valids did you test my last patch (you find it in my ftp area) that
removes the unstable pages from the equation? all ext3 as local fs ok,
but do you use nfs for the networked fs? If not can you post a way to
reproduce the hang? Is it enough to boot with mem=256M?

Thanks.
