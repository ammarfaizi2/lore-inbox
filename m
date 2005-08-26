Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbVHZBc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbVHZBc2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 21:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVHZBc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 21:32:28 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:33202 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965031AbVHZBc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 21:32:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=hHsANFIi3xPUd8nR3wSAM8+nu2uYdiYO0yzsyy5MZzupy3Myc9SqnsIeg/eLyREuPcT+i5ITJW3Y1NjXDr7unrBFQwBm+MuO4sBNwljr86vL5aRhzrDyYGVIuF5rAwaQARUs6DIkDoqMIAi4LWenEfPrd15Xx/GEOZ2PCH38AqA=  ;
Message-ID: <430E7132.9060800@yahoo.com.au>
Date: Fri, 26 Aug 2005 11:32:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       paulus@samba.org, mingo@elte.hu, hawkes@sgi.com, dino@in.ibm.com
Subject: Re: [PATCH 2.6.13-rc7 2/2] completely disable cpu_exclusive sched
 domain
References: <20050825194750.7341.75723.sendpatchset@jackhammer.engr.sgi.com> <20050825194756.7341.83327.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20050825194756.7341.83327.sendpatchset@jackhammer.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> At the suggestion of Nick Piggin and Dinakar, totally disable
> the facility to allow cpu_exclusive cpusets to define dynamic
> sched domains in Linux 2.6.13, in order to avoid problems
> first reported by John Hawkes (corrupt sched data structures
> and kernel oops).
> 
> This has been built for ppc64, i386, ia64, x86_64, sparc, alpha.
> It has been built, booted and tested for cpuset functionality
> on an SN2 (ia64).
> 
> Dinakar or Nick - could you verify that it for sure does avoid
> the problems Hawkes reported.  Hawkes is out of town, and I don't
> have the recipe to reproduce what he found.
> 

Thanks Paul, I was never able to reproduce the problem, but
I'm sure Dinakar should be able to test.

Acked-by: Nick Piggin <npiggin@suse.de>

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
