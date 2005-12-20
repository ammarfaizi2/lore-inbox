Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbVLTOMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbVLTOMQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 09:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVLTOMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 09:12:15 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:31126 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751054AbVLTOMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 09:12:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=3qdnclJmFieASOz8ZzG7JXbvu59p4omIc77Hn8cBSSCZgOUHCVOSUSGpxjYIv4ef3eFMJggPhcfXhFUL6h0dV+4s93IGSP1nj5TAno01uVMZr0uqa3ItDY/8XCPFGPFqgxeUJFfs6t2wQaqIhcGh+gn4erc+MLrQZJaoxwe+eRc=  ;
Message-ID: <43A81132.8040703@yahoo.com.au>
Date: Wed, 21 Dec 2005 01:12:02 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nicolas Pitre <nico@cam.org>
CC: Ingo Molnar <mingo@elte.hu>, David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
References: <20051219013507.GE27658@elte.hu> <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com> <1135025932.4760.1.camel@localhost.localdomain> <20051220043109.GC32039@elte.hu> <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain> <43A7BCE1.7050401@yahoo.com.au> <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre wrote:
> On Tue, 20 Dec 2005, Nick Piggin wrote:

>>Considering that on UP, the arm should not need to disable interrupts
>>for this function (or has someone refuted Linus?), how about:
> 
> 
> Kernel preemption.
> 

preempt_disable() ?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
