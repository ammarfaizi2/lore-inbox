Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTKCErU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 23:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTKCErU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 23:47:20 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:23475 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261916AbTKCErP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 23:47:15 -0500
Message-ID: <3FA5DDCF.5030700@cyberone.com.au>
Date: Mon, 03 Nov 2003 15:47:11 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rhino <rhino9@terra.com.br>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nick's scheduler v17a
References: <3F913704.5040707@cyberone.com.au>	<3FA08853.5050402@cyberone.com.au> <20031031185740.7c152d8b.rhino9@terra.com.br>
In-Reply-To: <20031031185740.7c152d8b.rhino9@terra.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rhino wrote:

>On Thu, 30 Oct 2003 14:41:07 +1100
>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>
>>http://www.kerneltrap.org/~npiggin/v17a/
>>
>>More balancing fixes. I also incorporated some of Andrew Theurer's
>>ideas. I'm generally getting good numbers now, but using fairly
>>synthetic benchmarks.
>>
>>Now would be a good time to test if anyone is interested. Thanks.
>>
>
>well i didn't have the time to make extensive tests yet, but the behaviour improved a lot since v16,
>and *looks* quite  better compared to test9 on a 2 way xeon p4 with hyperthreading enabled,
>seeing  4 cpu's.
>
>when i get back home, I'll try to make a few benchmarks.
>

That would be nice. There still isn't a lot of work done in the HT
department, but something simple and easy like the shared runqueues
patch might be reasonable for 2.6.


