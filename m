Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUGZLsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUGZLsC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 07:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUGZLsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 07:48:02 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:55167 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265222AbUGZLrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 07:47:49 -0400
Message-ID: <4104EF5F.9070405@yahoo.com.au>
Date: Mon, 26 Jul 2004 21:47:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: "R. J. Wysocki" <rjwysocki@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Autotune swappiness01
References: <cone.1090801520.852584.20693.502@pc.kolivas.org> <200407261234.29565.rjwysocki@sisk.pl> <4104DD27.6050907@kolivas.org> <200407261254.01186.rjwysocki@sisk.pl> <4104E4ED.7030901@kolivas.org> <4104E750.60400@yahoo.com.au> <4104E863.6070102@kolivas.org>
In-Reply-To: <4104E863.6070102@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Nick Piggin wrote:
> 
>> Con Kolivas wrote:

>>> In my ideal, nonsensical, impossible to obtain world we have an 
>>> autoregulating operating system that doesn't need any knobs.
>>>
>>
>> Some thinks are fundamental tradeoffs that can't be autotuned.
>>
>> Latency vs throughput comes up in a lot of places, eg. timeslices.
>>
>> Maximum throughput via effective use of swap, versus swapping as
>> a last resort may be another.
> 
> 
> As I said... it was ideal, nonsensical, and impossible. Doesn't sound 
> like you're arguing with me.

No, you're right. My ideal operating system knows what the user
wants too ;)

Most of the time though, you are right. The quality/desirability of an
implementation will be inversely proportional to the number of knobs
sticking out of it (with bonus points for those that are meaningful to
2 people on the planet).

And yes, I think one knob should be enough for swapping behaviour too.
