Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266453AbUHFCWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266453AbUHFCWa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267978AbUHFCWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:22:30 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:17290 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266453AbUHFCWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:22:22 -0400
Message-ID: <4112EB57.2020003@yahoo.com.au>
Date: Fri, 06 Aug 2004 12:22:15 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RSS ulimit enforcement for 2.6.8
References: <Pine.LNX.4.44.0408052056160.8229-100000@dhcp83-102.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408052056160.8229-100000@dhcp83-102.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Thu, 5 Aug 2004, Andrew Morton wrote:
>
>
>>Good question.  What I'm groping for here is some definition of what we
>>actually want the feature to _do_.  Once we have that, and have suitably
>>argued about it, we can then go off and see if the patch actually does it.
>>
>
>What I want the feature to do is allow users to set an
>RSS rlimit to prevent a process from hogging up all the
>machine's memory.
>
>I am not looking for a hard memory limit, since that
>would just cause extra IO, which has bad consequences
>for the rest of the system.
>
>In addition, I would like the patch to be relatively
>low impact, not giving us much maintenance overhead or
>much runtime overhead.
>
>If anybody has good reasons for needing hard per-process
>RSS limits, let us know.  So far I haven't seen anybody
>with a workload that somehow requires a hard limit.
>
>
FWIW, I like Rik's approach. One tiny request might be just to do the
patch underneath the thrashing control patch so it can be sent to Linus
earlier.

