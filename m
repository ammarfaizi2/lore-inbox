Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWEEFNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWEEFNN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 01:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWEEFNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 01:13:13 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:60338 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750923AbWEEFNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 01:13:12 -0400
Date: Fri, 5 May 2006 07:17:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Bob Picco <bob.picco@hp.com>, Dave Hansen <haveblue@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060505051735.GA5931@elte.hu>
References: <20060502070618.GA10749@elte.hu> <200605020905.29400.ak@suse.de> <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au> <20060504013239.GG19859@localhost> <1146756066.22503.17.camel@localhost.localdomain> <20060504154652.GA4530@localhost> <20060504192528.GA26759@elte.hu> <20060504194334.GH19859@localhost> <445A7725.8030401@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445A7725.8030401@shadowen.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Whitcroft <apw@shadowen.org> wrote:

> Yeah will have a look tommorrow my time.  Could you drop me the 
> .config too.  There is definatly some unstated requirements on 
> alignment, which I was testing today.  I presume its one of those 
> thats being violated.

the config is at:

 http://redhat.com/~mingo/misc/config

the bootlog is at:

 http://redhat.com/~mingo/misc/crash.log

	Ingo
