Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289345AbSAOBbz>; Mon, 14 Jan 2002 20:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289344AbSAOBbp>; Mon, 14 Jan 2002 20:31:45 -0500
Received: from freeside.toyota.com ([63.87.74.7]:14092 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S289345AbSAOBbZ>; Mon, 14 Jan 2002 20:31:25 -0500
Message-ID: <3C438657.4030403@lexus.com>
Date: Mon, 14 Jan 2002 17:31:03 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: J Sloan <jjs@pobox.com>, Robert Love <rml@tech9.net>,
        jogi@planetzork.ping.de, Andrew Morton <akpm@zip.com.au>,
        Ed Sweetman <ed.sweetman@wmich.edu>, Andrea Arcangeli <andrea@suse.de>,
        yodaiken@fsmlabs.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        nigel@nrg.org, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010946178.11848.14.camel@phantasy> <3C41E17A.4010909@pobox.com> <E16Q0wQ-0000ks-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

>On January 13, 2002 08:35 pm, J Sloan wrote:
>
>>The problem here is that when people report
>>that the low latency patch works better for them
>>than the preempt patch, they aren't talking about
>>bebnchmarking the time to compile a kernel, they
>>are talking about interactive feel and smoothness.
>>
>
>Nobody is claiming the low latency patch works better than 
>-preempt+lock_break, only that low latency can equal -preempt+lock_break, 
>which is a claim I'm skeptical of, but oh well.
>
AFAICT Alan Cox  et al are saying that low-latency
gives better latency than -preempt, but that if lock-break
is added to -preempt, the results are basically the same.

IOW lock-break + preempt =~ low-latency as far as the
latency question is concerned.

>>I've no agenda other than wanting to see linux
>>as an attractive option for the multimedia and
>>gaming crowds - and in my experience, the low
>>latency patches simply give a much smoother
>>feel and a more pleasant experience. Kernel
>>compilation time is the farthest thing from my
>>mind when e.g. playing Q3A!
>>
>
>You need to read the thread *way* more closely ;-)
>
Admittedly my observations have been more from
an "end-user" point of view, because at the end
of the day, what I experience while using Linux as
a multimedia/gaming platform is worth more than a
barrel of benchmarks - and while kernel compilation
time is of interest, it is just _one_  benchmark in the
greater scheme of things. (not to mention that that
benchmark result could probably be matched in a
non -preempt kernel via /proc tuning)


>>I'd be happy to check out the preempt patch
>>again and see if anything's changed, if the
>>problem of tux+preempt oopsing has been
>>dealt with -
>>
>
>Right, useful.
>
See my previous reply, or the archives -

Regards,

jjs



