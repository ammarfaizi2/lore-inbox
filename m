Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbULBGsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbULBGsn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 01:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbULBGsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 01:48:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12452 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261509AbULBGsk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 01:48:40 -0500
Message-ID: <41AEBAB9.3050705@pobox.com>
Date: Thu, 02 Dec 2004 01:48:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, clameter@sgi.com, hugh@veritas.com,
       benh@kernel.crashing.org, nickpiggin@yahoo.com.au, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
 tests
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>	<Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>	<Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>	<Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>	<Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>	<Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>	<Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>	<41AEB44D.2040805@pobox.com> <20041201223441.3820fbc0.akpm@osdl.org>
In-Reply-To: <20041201223441.3820fbc0.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> We need to be be achieving higher-quality major releases than we did in
> 2.6.8 and 2.6.9.  Really the only tool we have to ensure this is longer
> stabilisation periods.


I'm still hoping that distros (like my employer) and orgs like OSDL will 
step up, and hook 2.6.x BK snapshots into daily test harnesses.

Something like John Cherry's reports to lkml on warnings and errors 
would be darned useful.  His reports are IMO an ideal model:  show 
day-to-day _changes_ in test results.  Don't just dump a huge list of 
testsuite results, results which are often clogged with expected 
failures and testsuite bug noise.

	Jeff


