Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267753AbUHEP1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267753AbUHEP1T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267756AbUHEP1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:27:19 -0400
Received: from jade.spiritone.com ([216.99.193.136]:7841 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267753AbUHEP1R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:27:17 -0400
Date: Thu, 05 Aug 2004 08:25:59 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       Rick Lindsley <ricklind@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1: SCHEDSTATS compile error
Message-ID: <42030000.1091719559@[10.10.2.4]>
In-Reply-To: <20040805111835.GB2746@fs.tum.de>
References: <20040805031918.08790a82.akpm@osdl.org> <20040805111835.GB2746@fs.tum.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Adrian Bunk <bunk@fs.tum.de> wrote (on Thursday, August 05, 2004 13:18:35 +0200):

> On Thu, Aug 05, 2004 at 03:19:18AM -0700, Andrew Morton wrote:
>> ...
>> Changes since 2.6.8-rc2-mm2:
>> ...
>> +schedstats-2.patch
>> ...
>>  CPU scheduler statitics
>> ...
> 
> <--  snip  -->
> 
> ...
>   CC      kernel/sched.o
> kernel/sched.c: In function `show_schedstat':
> kernel/sched.c:372: error: structure has no member named `sd'
> kernel/sched.c:372: error: dereferencing pointer to incomplete type
> kernel/sched.c:375: error: dereferencing pointer to incomplete type
> kernel/sched.c:380: error: dereferencing pointer to incomplete type
> kernel/sched.c:381: error: dereferencing pointer to incomplete type
> kernel/sched.c:382: error: dereferencing pointer to incomplete type
> kernel/sched.c:383: error: dereferencing pointer to incomplete type
> kernel/sched.c:384: error: dereferencing pointer to incomplete type
> kernel/sched.c:387: error: dereferencing pointer to incomplete type
> kernel/sched.c:387: error: dereferencing pointer to incomplete type
> kernel/sched.c:388: error: dereferencing pointer to incomplete type
> kernel/sched.c:388: error: dereferencing pointer to incomplete type
> make[1]: *** [kernel/sched.o] Error 1

Any chance you could try the version Ingo just posted instead?

M.

