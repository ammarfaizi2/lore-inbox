Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274965AbTHKXkQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 19:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274966AbTHKXkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 19:40:16 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:45579 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S274965AbTHKXkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 19:40:11 -0400
Message-ID: <3F382CAC.1060502@techsource.com>
Date: Mon, 11 Aug 2003 19:54:20 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schlemmer <azarah@gentoo.org>
CC: Nick Piggin <piggin@cyberone.com.au>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]O14int
References: <200308090149.25688.kernel@kolivas.org>	 <200308111608.18241.kernel@kolivas.org> <3F375EBD.5030106@cyberone.com.au>	 <200308111943.49235.kernel@kolivas.org>  <3F376597.9000708@cyberone.com.au> <1060610663.13256.76.camel@workshop.saharacpt.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin Schlemmer wrote:

> 
> I did not say the 'make -j10s' starved.  I am saying that mouse
> is laggish, as well as window/desktop switching.
> 
> Also, I am not saying Con should fix it - I am asking if we really
> want one scheduler that should try to do the right thing for SMP
> *and* UP.


Putting aside the load balancer, isn't the SMP case little more than 
multiple UP schedulers running in parallel?

I think that was supposed to be one of the great things about the O(1) 
scheduler:  It unlocked the CPUs from each other so there would be far 
fewer spinlocks.


