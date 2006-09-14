Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWINSIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWINSIO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 14:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWINSIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 14:08:14 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:23696 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750788AbWINSIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 14:08:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=FDjx0du1PWsggSJSyBZhnvFRrMNp+66lm1nSJiQiHe8k17oSsLuybAAVEyE34SW3lqP6M3gPLELatVCnIO5+h8ZRZybxQrEryw/0xu121w6UUMLYdGE3HBBtH/LkGD0YSRDwhqV7qG6rUmhnsga10LpYIbl++eYZtdjnpUU965Y=  ;
Message-ID: <45099A81.8060206@yahoo.com.au>
Date: Fri, 15 Sep 2006 04:08:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Michel Dagenais <michel.dagenais@polymtl.ca>
CC: Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>	 <Pine.LNX.4.64.0609141537120.6762@scrub.home>	 <20060914135548.GA24393@elte.hu>	 <Pine.LNX.4.64.0609141623570.6761@scrub.home> <1158247596.5068.19.camel@localhost>
In-Reply-To: <1158247596.5068.19.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michel Dagenais wrote:
> On Thu, 2006-14-09 at 16:33 +0200, Roman Zippel wrote:

>>BTW I don't mind KProbes as an option, but I have huge problem with making 
>>it the only option.
> 
> 
> Indeed, KProbes SystemTAP and LTTng are complementary and people
> involved in the three projects are cooperating.

That doesn't mean we want them all in the kernel.

The best aim would of course be to come up with a solution that has
the advantages of all and disadvantages of none. That may be
impossible, but if we can find one way to do things that is acceptable
to all...

What's the huge problem with making kprobes the only option (that can't
be fixed by doing a bit of coding)?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
