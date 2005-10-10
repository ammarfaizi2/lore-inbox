Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbVJJRVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbVJJRVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbVJJRVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:21:24 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:53968 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751074AbVJJRVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:21:22 -0400
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Valdis.Kletnieks@vt.edu, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051010171525.GB13739@opteron.random>
References: <20050923153158.GA4548@x30.random>
	 <1127509047.8880.4.camel@kleikamp.austin.ibm.com>
	 <1127509155.8875.6.camel@kleikamp.austin.ibm.com>
	 <1127511979.8875.11.camel@kleikamp.austin.ibm.com>
	 <20050928223829.GH10408@opteron.random>
	 <1128126424.10237.7.camel@kleikamp.austin.ibm.com>
	 <20051002102726.GB26677@opteron.random>
	 <1128261072.9382.4.camel@kleikamp.austin.ibm.com>
	 <1128362768.8967.10.camel@kleikamp.austin.ibm.com>
	 <200510031831.j93IVQJT019379@turing-police.cc.vt.edu>
	 <20051010171525.GB13739@opteron.random>
Content-Type: text/plain
Date: Mon, 10 Oct 2005 12:21:20 -0500
Message-Id: <1128964880.8883.15.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-10 at 19:15 +0200, Andrea Arcangeli wrote:
> Hello,
> 
> So what's the status of this? Dave can you still reproduce hangs with
> your last jfs fixes applied?

With my latest jfs patch, I was unable to reproduce the hang on an
unmodified 2.6.14-rc2-mm1 kernel.

> Valids did you test my last patch (you find it in my ftp area) that
> removes the unstable pages from the equation? all ext3 as local fs ok,
> but do you use nfs for the networked fs? If not can you post a way to
> reproduce the hang? Is it enough to boot with mem=256M?
> 
> Thanks.
> 
-- 
David Kleikamp
IBM Linux Technology Center

