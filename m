Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267599AbTAXIlq>; Fri, 24 Jan 2003 03:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267602AbTAXIlq>; Fri, 24 Jan 2003 03:41:46 -0500
Received: from [210.212.228.4] ([210.212.228.4]:37304 "EHLO cnet.nitc.ac.in")
	by vger.kernel.org with ESMTP id <S267599AbTAXIlp>;
	Fri, 24 Jan 2003 03:41:45 -0500
Message-ID: <54208.210.212.228.78.1043398260.webmail@mail.nitc.ac.in>
Date: Fri, 24 Jan 2003 14:21:00 +0530 (IST)
Subject: Re: your mail
From: "Anoop J." <cs99001@nitc.ac.in>
To: <david.lang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.44.0301232225030.10187-100000@dlang.diginsite.com>
References: <42636.210.212.228.78.1043387664.webmail@mail.nitc.ac.in>
        <Pine.LNX.4.44.0301232225030.10187-100000@dlang.diginsite.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
X-Mailer: nitc webmail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I read that the data coherency problem due to virtual indexing is avoided
through page coloring and it has also got the speed of physical indexing
can u just elaborate on how this is possible?


Thanks




> implementing a fully associative cache eliminates the need for page
> coloring, but it has to be implemented in hardware. if you don't have
> fully associative caches in your hardware page coloring helps avoid the
> worst case memory allocations.
>
> from what I have seen on the attempts to implement it the problem is
> that the calculations needed to do page colored allocations end up
> costing enough that they end up with a net loss compared to the old
> method.
>
> David Lang
>
>
>  On Fri, 24 Jan 2003, Anoop J.
> wrote:
>
>> Date: Fri, 24 Jan 2003 11:24:24 +0530 (IST)
>> From: Anoop J. <cs99001@nitc.ac.in>
>> To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
>>
>>
>> How is this different from a fully associative cache .Would be better
>> if u could deal it based on the address bits used
>>



