Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267546AbTAXF5g>; Fri, 24 Jan 2003 00:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267547AbTAXF5g>; Fri, 24 Jan 2003 00:57:36 -0500
Received: from otter.mbay.net ([206.55.237.2]:48902 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S267546AbTAXF5f> convert rfc822-to-8bit;
	Fri, 24 Jan 2003 00:57:35 -0500
From: John Alvord <jalvo@mbay.net>
To: David Lang <david.lang@digitalinsight.com>
Cc: "Anoop J." <cs99001@nitc.ac.in>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: your mail
Date: Thu, 23 Jan 2003 22:06:24 -0800
Message-ID: <csl13vsmj20pfasoh5v4mmv5mv3chqm53m@4ax.com>
References: <40475.210.212.228.78.1043384883.webmail@mail.nitc.ac.in> <Pine.LNX.4.44.0301232104440.10187-100000@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.44.0301232104440.10187-100000@dlang.diginsite.com>
X-Mailer: Forte Agent 1.92/32.570
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The big challenge in Linux is that several serious attempts to add
page coloring have foundered on the shoals of "no benefit found". It
may be that the typical hardware Linux runs on just doesn't experience
the problem very much.

john


On Thu, 23 Jan 2003 21:11:10 -0800 (PST), David Lang
<david.lang@digitalinsight.com> wrote:

>The idea of page coloring is based on the fact that common implementations
>of caching can't put any page in memory in any line in the cache (such an
>implementation is possible, but is more expensive to do so is not commonly
>done)
>
>With this implementation it means that if your program happens to use
>memory that cannot be mapped to half of the cache lines then effectivly
>the CPU cache is half it's rated size for your program. the next time your
>program runs it may get a more favorable memory allocation and be able to
>use all of the cache and therefor run faster.
>
>Page coloring is an attampt to take this into account when allocating
>memory to programs so that every program gets to use all of the cache.
>
>David Lang
>
>
> On Fri, 24 Jan 2003, Anoop J. wrote:
>
>> Date: Fri, 24 Jan 2003 10:38:03 +0530 (IST)
>> From: Anoop J. <cs99001@nitc.ac.in>
>> To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
>>
>>
>> How does page coloring work. Iwant its mechanism not the implementation.
>> I went through some pages of W.L.Lynch's paper on cache and VM. Still not
>> able to grasp it .
>>
>>
>> Thanks in advance
>>
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

