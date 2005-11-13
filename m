Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbVKMFWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbVKMFWm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 00:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbVKMFWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 00:22:42 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:40384 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751353AbVKMFWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 00:22:41 -0500
Message-ID: <4376CD9F.6040309@bigpond.net.au>
Date: Sun, 13 Nov 2005 16:22:39 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH] plugsched - update Kconfig-1
References: <434F01EA.6060709@bigpond.net.au> <200511111417.03859.kernel@kolivas.org> <43769834.7080804@bigpond.net.au> <200511131244.48358.kernel@kolivas.org>
In-Reply-To: <200511131244.48358.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 13 Nov 2005 05:22:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Sun, 13 Nov 2005 12:34, Peter Williams wrote:
> 
>>Con Kolivas wrote:
>>
>>>Here's a respin just changing the spa menu.
>>
>>While agreeing that PlugSched's configuration needs overhaul I don't
>>think this is it as it just makes things more confusing.  I'll put
>>fixing the configuration code on my list of things to do.  They main
>>changes I see as necessary are:
>>
>>1. Make the ability to select which schedulers are built in independent
>>of EMBEDDED.
>>2. Only offer builtin schedulers as choice for the default scheduler.
>>3. Only build in ingosched if PLUGSCHED is not configured.
> 
> 
> I disagree with 3. Surely people might want to build in only one scheduler 
> that is not ingosched without other choices.

Yes, and they would be able to do that by selecting PLUGSCHED and then 
selecting only the scheduler that they want.  But this then leads to the 
observation that PLUGSCHED is probably makes things unnecessarily 
complex and all that is required is a means to select the schedulers to 
be built in and a choice of default (much like for the IO schedulers)?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
