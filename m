Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267117AbSLSV47>; Thu, 19 Dec 2002 16:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267173AbSLSV47>; Thu, 19 Dec 2002 16:56:59 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:41686 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S267117AbSLSV46>;
	Thu, 19 Dec 2002 16:56:58 -0500
Date: Thu, 19 Dec 2002 23:04:55 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Burgess <aab@cichlid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HT Benchmarks (was: /proc/cpuinfo and hyperthreading)
Message-ID: <20021219220455.GA26489@werewolf.able.es>
References: <1_0212161441436926@cichlid.com> <200212181756.gBIHuud27855@athlon.cichlid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200212181756.gBIHuud27855@athlon.cichlid.com>; from aab@cichlid.com on Wed, Dec 18, 2002 at 18:56:56 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.18 Andrew Burgess wrote:
>>Number of threads	Elapsed time   User Time   System Time
>>1                   53:216           53:220    00:000
>>2                   29:272           58:180    00:320
>>3                   27:162         1:21:450    00:540
>>4                   25:094         1:41:080    01:250
>
>>Elapsed is measured by the parent thread, that is not doing anything
>>but wait on a pthread_join. User and system times are the sum of
>>times for all the children threads, that do real work.
>
>>The jump from 1->2 threads is fine, the one from 2->4 is ridiculous...
>>I have my cpus doubled but each one has half the pipelining for floating
>>point...see the user cpu time increased due to 'worst' processors and
>>cache pollution on each package.
>
>>So, IMHO and for my apps, HyperThreading is just a bad joke.
>
>Why do you care about user time? The elapsed time went down by
>4 minutes (2->4 threads), if that's a joke I don't get it :-)
>
>New Intel Ad: "What are you going to do with your 4 minutes today?"
>

Of course I gain something. The problem is the price you pay for the
gain.

Prices in Spain: a P4 with 512Kb cache, 210 euros. Equal features (freq,
cache), but Xeon version, 320 euros. So you pay 50% more money for
10% more performance. Not too fair...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam2 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))
