Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWJ3SIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWJ3SIR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWJ3SIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:08:16 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:26315 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S932473AbWJ3SIN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:08:13 -0500
Message-ID: <45463F70.1010303@in.ibm.com>
Date: Mon, 30 Oct 2006 23:37:44 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Pavel Emelianov <xemul@openvz.org>, vatsa@in.ibm.com, dev@openvz.org,
       sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, pj@sgi.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com, rohitseth@google.com,
       menage@google.com, linux-mm@kvack.org
Subject: Re: [ckrm-tech] RFC: Memory Controller
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com> <4546212B.4010603@openvz.org> <454638D2.7050306@in.ibm.com>
In-Reply-To: <454638D2.7050306@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
[snip]

>
>> I see that everyone agree that we want to see three resources:
>>   1. kernel memory
>>   2. unreclaimable memory
>>   3. reclaimable memory
>> if this is right then let's save it somewhere
>> (e.g. http://wiki.openvz.org/Containers/UBC_discussion)
>> and go on discussing the next question - interface.
> 
> I understand that kernel memory accounting is the first priority for
> containers, but accounting kernel memory requires too many changes
> to the VM core, hence I was hesitant to put it up as first priority.
> 
> But in general I agree, these are the three important resources for
> accounting and control

I missed out to mention, I hope you were including the page cache in
your definition of reclaimable memory.

> 
> [snip]
> 


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
