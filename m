Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267879AbUH0VMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267879AbUH0VMx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267840AbUH0VMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:12:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27279 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267657AbUH0UvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:51:10 -0400
Message-ID: <412F9EB4.4020206@pobox.com>
Date: Fri, 27 Aug 2004 16:51:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Peck <coderman@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: faster via/centaur hw rng throughput patch for 2.6.8.1
References: <4ef5fec604082711523b3935f9@mail.gmail.com> <412F87D8.6020009@pobox.com> <4ef5fec604082713307d1b312@mail.gmail.com>
In-Reply-To: <4ef5fec604082713307d1b312@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peck wrote:
> On Fri, 27 Aug 2004 15:13:28 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Honestly I would rather just remove the VIA support from the kernel
>>completely:  it belongs in the userspace rngd
> 
> 
> this sounds like a better solution to me as well.  is there anything
> that uses /dev/hwrandom which might be affected?

I'll answer the question that your question raises :)

I don't want to remove VIA support from hw_random the instant that 
support is added to rngd.

Rather, that would be the first step in phasing VIA RNG support out of 
the kernel.  The second step would be printing a one-time warning, 
noting the VIA support is deprecated, and that we will not be adding any 
code it.  The third step, probably when 2.7 opens, is to then remove the 
VIA support from hw_random.


>>I've been meaning to do this for a while, wanna volunteer?  ;-)
> 
> 
> i can poke at it; be careful what you wish for!

hehe :)

	Jeff



