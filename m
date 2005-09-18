Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbVIRIO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbVIRIO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 04:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVIRIOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 04:14:55 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:47985 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751326AbVIRIOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 04:14:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=RvEtA53zKC8UJmBoECFFDJorztSwjnsh3kdt5coMqfBc4/BXJeFMqQ2RjZrVhtbib9ST60r1AdtLrfuUE0yKLmPAev7hK84c4P7fr6U2EERxDqnzzrLHOqEQnoYnojhzq1C/RcRm58EMlN8lKWXK0nHG7ffkSYeU8P0Gy0UYhOw=  ;
Message-ID: <432D2231.4040903@yahoo.com.au>
Date: Sun, 18 Sep 2005 18:15:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: "liyu@WAN" <liyu@ccoss.com.cn>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Question] Can we release vma that include code when one process
 is running?
References: <432919C3.7060708@ccoss.com.cn> <43296D1D.4000407@yahoo.com.au> <432A7C0F.8050903@ccoss.com.cn>
In-Reply-To: <432A7C0F.8050903@ccoss.com.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

liyu@WAN wrote:
> 
> 
> Sorry, I perhaps didn't said clearly.
> 
> As I knwon, if we remove vma from vma tree of task, the SIGSEGV must be 
> got!
> but I am not removed them , I just unmapped them. and the SIGSEGV occurs 
> some times,
> not alway.
> 
> I doublt on it.
> 
> Any clearly idea?
> 

No clear ideas, no. Are you doing the proper synchronization and
flushing required when unmapping those regions?

If you can post your unmapping code to lkml, someone might be able
to spot a bug in it.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
