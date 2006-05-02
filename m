Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWEBT4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWEBT4S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWEBT4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:56:18 -0400
Received: from dvhart.com ([64.146.134.43]:58075 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751236AbWEBT4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:56:17 -0400
Message-ID: <4457B960.40701@mbligh.org>
Date: Tue, 02 May 2006 12:56:16 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
References: <20060419112130.GA22648@elte.hu> <200605021745.32907.ak@suse.de> <20060502194828.GB10072@elte.hu> <200605022144.56586.ak@suse.de>
In-Reply-To: <200605022144.56586.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 02 May 2006 21:48, Ingo Molnar wrote:
> 
>>* Andi Kleen <ak@suse.de> wrote:
>>
>>
>>>i386: Panic the system early when a NUMA kernel doesn't run on IBM 
>>>NUMA
>>
>>nah! Lets just fix the zone sizing bug ...
> 
> 
> The problem is that nobody regression tests it. So even if you fix it
> now it will be likely broken again in a few months.

We can add a box to the test.kernel.org harness easily enough, and
it will show up with an eerie red glow.

M.
