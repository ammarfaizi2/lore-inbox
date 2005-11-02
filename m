Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbVKBSJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbVKBSJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbVKBSJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:09:11 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:65041 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S965143AbVKBSJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:09:09 -0500
Message-ID: <43690083.5020605@shadowen.org>
Date: Wed, 02 Nov 2005 18:08:03 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Andi Kleen <ak@suse.de>, Bob Picco <bob.picco@hp.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: x86_64: 2.6.14 with NUMA panics at boot
References: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi> <1130607017.12551.5.camel@localhost> <20051031001727.GC6019@localhost.localdomain> <200510310312.18395.ak@suse.de> <222900000.1130908059@[10.10.2.4]>
In-Reply-To: <222900000.1130908059@[10.10.2.4]>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> 
> --Andi Kleen <ak@suse.de> wrote (on Monday, October 31, 2005 03:12:17 +0100):
> 
> 
>>On Monday 31 October 2005 01:17, Bob Picco wrote:
>>Ok the question is - why did nobody submit this patch in time? When
>>sparse was merged I assumed folks would actually test and maintain
>>it. But that doesn't seem to be the case? Somewhat surprising.

We are activly maintaining sparsemem.  But we do seem to have fallen
short on the testing front on some of the architectures.  I'm looking
right now into getting some automated testing sorted out for SPARSEMEM
specifically so that we catch this stuff much earlier in the pipeline,
as its much simpler for us to find the earlier a problem appears.

>>I personally don't care much about sparsemem right now because it doesn't have 
>>any advantage and if it's unmaintained would consider to mark it 
>>CONFIG_BROKEN. That's simply because we can't have highly experimental 
>>CONFIGs in a production kernel that unsuspecting users can just set and break 
>>their configuration.
>>
>>Dave, is there someone in charge for sparsemem on x86-64?

I had assumed that it was being maintained, but its not obvious from
this thread that we're all on the same page.  But we'll find out and get
that sorted.

-apw
