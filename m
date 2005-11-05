Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbVKEJTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVKEJTx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 04:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbVKEJTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 04:19:53 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:1106 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751306AbVKEJTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 04:19:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=U57NsFGIJEMRb4FzV4b+KcyVFw5Ubs486wMDDzB7yLacXqQoKY1GdznHwWSOz9SvXrkKfYbFUj7AlVVgx26Ne2xDTUBgUBaUQb/Pw8wVd95SrFvMp5UVnSRZtKXf7rhLDM6vNPlhjljR1Oij/smSvh30Ngx7Dr+GLasx0/mxcsw=  ;
Message-ID: <436C79B6.3020004@yahoo.com.au>
Date: Sat, 05 Nov 2005 20:21:58 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 2/5] atomic: cmpxchg
References: <436C655F.2080703@yahoo.com.au> <436C65B1.5020508@yahoo.com.au> <436C65E8.8080501@yahoo.com.au> <20051105090010.GA18926@flint.arm.linux.org.uk> <436C771D.8040703@yahoo.com.au> <20051105091311.GA19516@flint.arm.linux.org.uk>
In-Reply-To: <20051105091311.GA19516@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sat, Nov 05, 2005 at 08:10:53PM +1100, Nick Piggin wrote:
> 
>>While you're here, does the assembly code for the SMP version look
>>OK? You basically provided me with it but I don't think you saw its
>>final form.
> 
> 
> Looks fine.  The only comment is changing the "r" (old) to be
> "Ir" (old).  The "I" tells the compiler that it may also use a
> constant for that argument, which may allow it to optimise the
> code a bit better.
> 

Thanks. Will submit a new patch after this round of feedback.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
