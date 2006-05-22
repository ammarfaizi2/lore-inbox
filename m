Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWEVVbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWEVVbw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 17:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWEVVbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 17:31:52 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:41873 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751212AbWEVVbv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 17:31:51 -0400
Message-ID: <44722DAE.3020205@vilain.net>
Date: Tue, 23 May 2006 09:31:26 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, ebiederm@xmission.com, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, serue@us.ibm.com
Subject: Re: [PATCH] namespaces: uts_ns: make information visible via /proc/PID/uts
 directory
References: <20060522052425.27715.94562.stgit@localhost.localdomain> <20060522010414.6dfb4f71.akpm@osdl.org>
In-Reply-To: <20060522010414.6dfb4f71.akpm@osdl.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Sam Vilain <sam@vilain.net> wrote:
>  
>
>>Export the UTS information to a per-process directory /proc/PID/uts,
>> that has individual nodes for hostname, ostype, etc - similar to
>> those in /proc/sys/kernel
>>    
>>
>umm, why?
>  
>

Er, for the same reason we have /proc/PID/mounts ?

>> This duplicates the approach used for /proc/PID/attr, which involves a
>> lot of duplication of similar functions.  Much room for maintenance
>> optimisation of both implementations remains.
>> fs/proc/base.c |  236 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>
>ouch.
>  
>

Also yow. Refer above gross understatement.

Sam.

