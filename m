Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWAaSsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWAaSsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 13:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWAaSsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 13:48:13 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:37610 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751339AbWAaSsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 13:48:13 -0500
Message-ID: <43DFB0D7.3070805@us.ibm.com>
Date: Tue, 31 Jan 2006 12:47:51 -0600
From: Brian Twichell <tbrian@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ray Bryant <raybry@mpdtxmail.amd.com>
CC: Hugh Dickins <hugh@veritas.com>, Dave McCracken <dmccr@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]> <Pine.LNX.4.61.0601202020001.8821@goblin.wat.veritas.com> <43DAA3C9.9070105@us.ibm.com> <200601301246.27455.raybry@mpdtxmail.amd.com>
In-Reply-To: <200601301246.27455.raybry@mpdtxmail.amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant wrote:

>On Friday 27 January 2006 16:50, Brian Twichell wrote:
><snip>
>
>  
>
>>Hi,
>>
>>We collected more granular performance data for the ppc64/hugepage case.
>>
>>CPI decreased by 3% when shared pagetables were used.  Underlying this was
>>a 7% decrease in the overall TLB miss rate.  The TLB miss rate for
>>hugepages decreased 39%.  TLB miss rates are calculated per instruction
>>executed.
>>
>>    
>>
>
>Interesting.
>
>Do you know if Dave's patch supports sharing of pte's for 2 MB pages on 
>X86_64?
>  
>
I believe it does.  Dave, can you confirm ?

>Was there a corresponding improvement in overall transaction throughput for 
>the hugetlb, shared pte case?    That is, did the 3% improvement in CPI 
>translate to a measurable improvement in the overall OLTP benchmark score?
>  
>
Yes.  My original post with performance data described a 3% improvement
in the ppc64/hugepage case.  This is a transaction throughput statement.

>(I'm assuming your 25-50% improvement measurements, as mentioned in a previous 
>note, was for small pages.)
>
>  
>
That's correct.


