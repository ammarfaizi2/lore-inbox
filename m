Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265158AbTLKQlQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 11:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265159AbTLKQlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 11:41:15 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:47824 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265158AbTLKQlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 11:41:11 -0500
Message-ID: <3FD89E23.3000605@cyberone.com.au>
Date: Fri, 12 Dec 2003 03:41:07 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][RFC] HT scheduler
References: <3FD3FD52.7020001@cyberone.com.au> <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au> <20031209001412.GG19412@krispykreme> <3FD7F1B9.5080100@cyberone.com.au> <3FD89B45.8040905@backtobasicsmgmt.com>
In-Reply-To: <3FD89B45.8040905@backtobasicsmgmt.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kevin P. Fleming wrote:

> Nick Piggin wrote:
>
>> http://www.kerneltrap.org/~npiggin/w26/
>> Against 2.6.0-test11
>>
>> This includes the SMT description for P4. Initial results shows 
>> comparable
>> performance to Ingo's shared runqueue's patch on a dual P4 Xeon.
>>
>
> Is there any value in testing/using this on a single CPU P4-HT system, 
> or is it only targeted at multi-CPU systems?


Yes hopefully there is value in it. Its probably very minor, but it
recognises there is no cache penalty when moving between virtual CPUs,
so it should be able to keep them busy more often.

As I said it would be very minor.


