Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275774AbTHOIMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 04:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275778AbTHOIMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 04:12:15 -0400
Received: from dyn-ctb-203-221-74-26.webone.com.au ([203.221.74.26]:25351 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S275774AbTHOIMD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 04:12:03 -0400
Message-ID: <3F3C95A9.8000203@cyberone.com.au>
Date: Fri, 15 Aug 2003 18:11:21 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
References: <20030809173329.GU31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030814165320.GA2839@speare5-1-14> <bhgoj9$9ab$1@abraham.cs.berkeley.edu> <20030815001713.GD5333@speare5-1-14> <20030815093003.A2784@pclin040.win.tue.nl> <20030815004004.52f94f9a.davem@redhat.com> <20030815095503.C2784@pclin040.win.tue.nl> <yw1xfzk3pcod.fsf@users.sourceforge.net>
In-Reply-To: <yw1xfzk3pcod.fsf@users.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Måns Rullgård wrote:

>Andries Brouwer <aebr@win.tue.nl> writes:
>
>
>>>>>entropy(x) >= entropy(x xor y)
>>>>>entropy(y) >= entropy(x xor y)
>>>>>
>>>>Is this trolling? Are you serious?
>>>>
>>>These lemma are absolutely true.
>>>
>>David, did you read this line:
>>
>>
>>>>Try to put z = x xor y and apply your insight to the strings x and z.
>>>>
>>Let us do it. Let z be an abbreviation for x xor y.
>>
>>The lemma that you believe in, applied to x and z, says
>>
>> entropy(x) >= entropy(x xor z)
>> entropy(z) >= entropy(x xor z)
>>
>>But x xor z equals y, so you believe for arbitrary strings x and y that
>>
>> entropy(x) >= entropy(y)
>> entropy(x xor y) >= entropy(y).
>>
>>This "lemma", formulated in this generality, is just plain nonsense.
>>
>
>Not quite non-sense, but it would mean that for any strings x and y, 
>
>  entropy(x) == entropy(y),
>
>which seems incorrect.
>

Well, just the line entropy(x) >= entropy(y) is incorrect. ie. proof
by contradiction.


