Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUDSLxg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 07:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUDSLxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 07:53:36 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:52097 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263802AbUDSLxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 07:53:34 -0400
Message-ID: <4083BDBB.2050904@yahoo.com.au>
Date: Mon, 19 Apr 2004 21:53:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Pedro Larroy <piotr@larroy.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: CFQ iosched praise: good perfomance and better latency
References: <20040419005651.GA7860@larroy.com> <40835F4E.5000308@yahoo.com.au> <20040418225752.56d10695.akpm@osdl.org> <40836DE8.5080303@yahoo.com.au> <20040419113243.GA18042@larroy.com>
In-Reply-To: <20040419113243.GA18042@larroy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pedro Larroy wrote:
> On Mon, Apr 19, 2004 at 04:12:56PM +1000, Nick Piggin wrote:

>>Well I think Pedro actually means *seconds*, not ms. The URL
>>shows AS peaks at nearly 10 seconds latency, and CFQ over 2s.
> 
> 
> Yes, I meant seconds, my mistake. I will be testing elevator=noop this
> evening.
> 

That would be interesting.

> 
>>It really seems like a raid problem though, because latency
>>measured at the individual devices is under 250ms for AS.
> 
> 
> Probably. But I was surprised to find that bonnie gave similar results
> with CFQ and with AS when benchmarking the swraid5.

I haven't used bonnie, but I think it is single threaded, isn't
it? If that is the case, then the IO scheduler will make little
or no difference, so your result is not surprising.
