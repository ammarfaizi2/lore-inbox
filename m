Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUCABpM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 20:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbUCABpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 20:45:12 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:15314 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262080AbUCABpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 20:45:07 -0500
Message-ID: <4042959D.5020100@cyberone.com.au>
Date: Mon, 01 Mar 2004 12:45:01 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nikita@Namesys.COM
Subject: Re: 2.6.4-rc1-mm1
References: <20040229140617.64645e80.akpm@osdl.org>	<40428B95.1000600@cyberone.com.au> <20040229171452.2e209835.akpm@osdl.org> <40429228.1080301@cyberone.com.au>
In-Reply-To: <40429228.1080301@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
>
> Andrew Morton wrote:
>
>> One point I would make is that if a workload is only achieving 5% CPU
>> anyway, we shouldn't optimise for it.  Sure, it's nice to be able to 
>> get it
>> up to 7% but it is much more important to get the 50% CPU workload up to
>> 70%.  The 5% problem is a fiscal one, not an engineering one ;)
>>
>
> I agree. I'm much more interested in getting light and medium swapping
> working better.
>

Just so I'm not misunderstood, I must add that I found Nikita's
patch to definitely help light and medium swapping kbuild runs.
The fact that it *really* helped heavy swapping is a bonus.

But I agree that we need more meaningful tests too. Maybe things
like overloading apache or a mail or database server might be
interesting.

