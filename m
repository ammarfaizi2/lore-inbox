Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbVKOIz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbVKOIz0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbVKOIz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:55:26 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:29372 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751386AbVKOIzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:55:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2uKpYrldgSnxu1QVPx+LuXYckihMFPVxWwpYXM4iqQC1qgmvF3/Vicevute8m03ed0CvHAbkW9J5tmNnskhqGwID5QwlNOVO9sV27vdTJYGlG0hAZMTJa2PaOwvfJeSR3/5A1ksjt9vyvcgWATKENAl0osAtdKPID0CruUEvlE0=  ;
Message-ID: <4379A30A.2090200@yahoo.com.au>
Date: Tue, 15 Nov 2005 19:57:46 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/5] atomic: atomic_inc_not_zero
References: <436416AD.3050709@yahoo.com.au>	<4364171C.7020103@yahoo.com.au>	<43641755.5010004@yahoo.com.au>	<4364178E.8040502@yahoo.com.au>	<20051114082956.609ff5cd.pj@sgi.com>	<20051114134841.083ea51c.akpm@osdl.org>	<20051114140216.3481799a.pj@sgi.com> <20051114150945.7078e51a.akpm@osdl.org>
In-Reply-To: <20051114150945.7078e51a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Paul Jackson <pj@sgi.com> wrote:
> 
>>>Please send patch.
>>
>>I can't.  I don't understand what Nick intends here.
>>If it's obvious to you, hit me with a clue stick,
>>and I'd be glad to patch it.
>>
> 
> 
> This, I assume?
> 

Yes. Doh. Thanks.

> --- 25/arch/sparc/lib/atomic32.c~sparc32-atomic32-build-fix	Mon Nov 14 15:08:44 2005
> +++ 25-akpm/arch/sparc/lib/atomic32.c	Mon Nov 14 15:08:48 2005
> @@ -66,7 +66,6 @@ int atomic_add_unless(atomic_t *v, int a
>  	return ret != u;
>  }
>  
> -static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
>  /* Atomic operations are already serializing */
>  void atomic_set(atomic_t *v, int i)
>  {
> _
> 
> 

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
