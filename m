Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162435AbWLBAoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162435AbWLBAoi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 19:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162437AbWLBAoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 19:44:37 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:55964 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1162435AbWLBAog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 19:44:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=b7eFstpOT5EWfdi3ZyVAXkzP1c5g6DeMEgYTCSCiru2twXuM6s8uo6+etqsAUmHXVVV0FJ7PYQg6nDdFlkZY3olJssz6jkL0d/JDE4UXsFrJ2JMX9jgwISiPxA8OBsf5hiQ0e3EahPauo/S6VdoDF4FKsFiiLmP8Mxn7kWQ5L5c=  ;
X-YMail-OSG: 9pqf5CEVM1npEYo4zw4eeCUSmsQa2AZuZ1Pu1r6c9TW9rI6nYVTpKre_qJ.FZD9YHnc4zkHSF8CLzvLIdt2t3UmAGwTI9mmNvwNVlOJGo7qCig--
Message-ID: <4570CC3E.40805@yahoo.com.au>
Date: Sat, 02 Dec 2006 11:43:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH 1/2] atomic.h atomic64_t standardization
References: <20061124215518.GE25048@Krystal> <20061127165643.GD5348@infradead.org> <20061201031153.GA10835@Krystal> <20061201032411.GA32440@Krystal> <20061201221912.GA10075@Krystal>
In-Reply-To: <20061201221912.GA10075@Krystal>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> Hi,
> 
> I finalized the work for atomic64_t cmpxchg and atomic64_add_unless on all
> architectures. asm-generic/atomic.h atomic_long_t is also streamlined.
> 
> Review is welcome.

Beautiful! Now I can do the rwsem consolidation. Thanks.

Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
