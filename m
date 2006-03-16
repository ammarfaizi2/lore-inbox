Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752296AbWCPJj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbWCPJj7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 04:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbWCPJj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 04:39:59 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:4183 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751222AbWCPJj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 04:39:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vc4o4cOeuGfXPHkOJGTJ1li9vRNgsF81wsDKRcZAy/RxlmPT+i8K123nP84wwonsSLO7yX7sKH+x2GDjJ6gAJ4OydI3+tvjV42m4dNFeq7//hIpRC5jyJD2CVLgGIjZTiGVWaexQH2iQY0YzbyAyehR3LQtotkVlCKn9pGv5Gxc=  ;
Message-ID: <44190A7C.6030901@yahoo.com.au>
Date: Thu, 16 Mar 2006 17:49:32 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] for_each_possible_cpu [1/19] defines for_each_possible_cpu
References: <20060316122110.c00f4181.kamezawa.hiroyu@jp.fujitsu.com>	<4418DEEA.2000008@yahoo.com.au>	<20060316131743.d7b716e9.kamezawa.hiroyu@jp.fujitsu.com>	<4418E879.3000207@yahoo.com.au> <20060316152206.7ac3bdb4.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060316152206.7ac3bdb4.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki wrote:
> On Thu, 16 Mar 2006 15:24:25 +1100
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>>I'm sure that renaming for_each_cpu would not prevent that either.
>>
> 
> 
> But maintainers can check easily whether online or possible should be,
> when they received a patch which includes for_each_cpu().
> 

The submitter of the patch should have already thought of that
regardless of the name of the function. Everybody should be on
the same page anyway because for_each_cpu has always meant for
each possible CPU.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
