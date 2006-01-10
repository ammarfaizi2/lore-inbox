Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWAJAvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWAJAvK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWAJAvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:51:10 -0500
Received: from smtp-out.google.com ([216.239.45.12]:43539 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750971AbWAJAvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:51:09 -0500
Message-ID: <43C304E7.7000508@google.com>
Date: Mon, 09 Jan 2006 16:50:47 -0800
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, apw@shadowen.org, greg@kroah.com
Subject: Re: Problems with 2.6.15-mm1 and mm2.
References: <43C2A48F.6030407@google.com>	<20060109154127.6a7e6972.akpm@osdl.org>	<43C2FA2E.2040704@google.com> <20060109164653.23b2676e.akpm@osdl.org>
In-Reply-To: <20060109164653.23b2676e.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Below is cut & pasted, so not applyable, and maybe it shouldn't be 
>> applied. But ... it worked before whatever is in -mm ... so my personal 
>> feeling is that if we don't have a fix for whatever is currently in -mm, 
>> it should get dropped until we do ? Going backwards = bad.
>>
>> Perhaps I'm in a time loop, and just confused. but I don't think so ?
> 
> 
> This isn't at all clear, sorry.
> 
> Does the patch you sent fix things in 2.6.15-mm2?  On NUMAQ and on x86_64? 
> Does it fix a bug which was introduced in a patch which in in 2.6.15-mm2? 
> If so, which one?

It fixes the symptom, yes. Greg complained it's papering over the 
problem and not a real fix, which is fair enough, but ...

yes, it did seem to be a newly introduced problem in -mm1 or -mm2. To my 
mind, if we don't have a proper fix, we ought to drop the patch that 
caused the problem in the first place? Andy .. can you finger which 
patch that was, I forget ...

M.

