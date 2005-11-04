Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbVKDQO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbVKDQO3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbVKDQO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:14:29 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:54576 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S1751600AbVKDQO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:14:28 -0500
To: andy@thermo.lanl.gov, torvalds@osdl.org
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Cc: akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie, mingo@elte.hu,
       nickpiggin@yahoo.com.au
In-Reply-To: <Pine.LNX.4.64.0511040738540.27915@g5.osdl.org>
Message-Id: <20051104161420.9CFA8184631@thermo.lanl.gov>
Date: Fri,  4 Nov 2005 09:14:20 -0700 (MST)
From: andy@thermo.lanl.gov (Andy Nelson)
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus:

>> If your and other kernel developer's (<<0.01% of the universe) kernel
>> builds slow down by 5% and my and other people's simulations (perhaps 
>> 0.01% of the universe) speed up by a factor up to 3 or 4, who wins? 
>
>First off, you won't speed up by a factor of three or four. Not even 
>_close_. 

My measurements of factors of 3-4 on more than one hw arch don't
mean anything then? BTW: Ingo Molnar has a response that did find 
my comp.arch posts. As I indicated to him, I've done a lot of code
tuning to get better performance even in the presence of tlb issues.
This factor is what is left. Starting from an untuned code, the factor
can be up to an order of magnitude larger. As in 30-60. Yes, I've
measured that too, though these detailed measurments were only on
mips/origins.


It is true that I have never had the opportunity to test these
issues on x86 and its relatives. Perhaps it would be better there.
The relative insensitivity of the results I have already to hw 
arch, indicate otherwise though.


Re maintainability: Fine. I like maintainable code too. Coding
standards are great. Language standards are even better.

These are motherhood statements. Your simple rejections
("NO, HELL NO!!") even of any attempts to make these sorts
of improvements seems to make that issue pretty moot anyway. 



Andy


