Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263811AbTLTDzt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 22:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbTLTDzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 22:55:49 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:49044 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263811AbTLTDzr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 22:55:47 -0500
Message-ID: <3FE3C840.4000702@cyberone.com.au>
Date: Sat, 20 Dec 2003 14:55:44 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Huo Zhigang <zghuo@ncic.ac.cn>
CC: linux-kernel@vger.kernel.org
Subject: Re: lmbench 2.4.20-8(RH9), 2.4.20, 2.6.0
References: <20031220034548.GA4809@lucent>
In-Reply-To: <20031220034548.GA4809@lucent>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Huo Zhigang(???) wrote:

>Howdy, 
>
>Is the network performance of 2.6.0 so bad or my test
>totally wrong?
>
>Could anyone tell me how to dig into performance
>optimization of linux?
>

This has come up a few times, but nobody is too worried about it.
I have profiles showing that more than double the amount of time
is spent in copying data for the same amount of work.

Its worth noting though, that it is "networking" over localhost.
I expect the numbers for remote networking are better, but don't
have a good network setup to test it.

Do you have any real applications (not benchmarks) that have
performance problems?


