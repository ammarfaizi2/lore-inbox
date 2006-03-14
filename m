Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWCNE3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWCNE3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 23:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbWCNE3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 23:29:13 -0500
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:5836 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750886AbWCNE3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 23:29:10 -0500
Date: Mon, 13 Mar 2006 23:29:08 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch 9/9] Generic netlink interface for delay accounting
In-reply-to: <1142303607.24621.63.camel@stark>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jamal <hadi@cyberus.ca>,
       netdev <netdev@vger.kernel.org>
Message-id: <44164694.6080206@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <1142296834.5858.3.camel@elinux04.optonline.net>
 <1142297791.5858.31.camel@elinux04.optonline.net>
 <1142303607.24621.63.camel@stark>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley wrote:

>On Mon, 2006-03-13 at 19:56 -0500, Shailabh Nagar wrote:
><snip>
>
>  
>
>>Comments addressed (all in response to Jamal)
>>
>>- Eliminated TASKSTATS_CMD_LISTEN and TASKSTATS_CMD_IGNORE
>>    
>>
>
>The enums for these are still in the patch. See below.
>
><snip>
>
>  
>
>>+/*
>>+ * Commands sent from userspace
>>+ * Not versioned. New commands should only be inserted at the enum's end
>>+ */
>>+
>>+enum {
>>+       TASKSTATS_CMD_UNSPEC,           /* Reserved */
>>+       TASKSTATS_CMD_NONE,             /* Not a valid cmd to send
>>+                                        * Marks data sent on task/tgid exit */
>>+       TASKSTATS_CMD_LISTEN,           /* Start listening */
>>+       TASKSTATS_CMD_IGNORE,           /* Stop listening */
>>    
>>
>
>>From the description I thought you had eliminated these.
>  
>

Yup, typo. the commands aren't registered but the enums hang on.
Will fix.

--Shailabh

