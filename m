Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbSLWBbV>; Sun, 22 Dec 2002 20:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265636AbSLWBbV>; Sun, 22 Dec 2002 20:31:21 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:3456 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S265633AbSLWBbT> convert rfc822-to-8bit; Sun, 22 Dec 2002 20:31:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: David Lang <david.lang@digitalinsight.com>, Robert Love <rml@tech9.net>
Subject: Re: [BENCHMARK] scheduler tunables with contest - starvation_limit
Date: Mon, 23 Dec 2002 12:40:58 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0212221703070.10806-100000@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.44.0212221703070.10806-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212231241.01049.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>one other thing that would be interesting to test on the osdl machines
>would be the effect of different filesystems.
>
>the origional set of tests were all done on reiserfs, it would be
>interesting to see if there is a difference between it and the others.

The current osdl hardware uses ext3 in the default journalling mode. Trying 
different filesystems is something I have had planned for a while. When I get 
the hardware sorted out as I need it to do this I will post some results 
where comparisons can be made.

See the current specs here:
http://www.osdl.org/projects/ctdevel/results/

Con
>
>David Lang
>
>On 22 Dec 2002, Robert Love wrote:
>> Date: 22 Dec 2002 20:06:51 -0500
>> From: Robert Love <rml@tech9.net>
>> To: Con Kolivas <conman@kolivas.net>
>> Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
>> Subject: Re: [BENCHMARK] scheduler tunables with contest -
>>     starvation_limit
>>
>> On Thu, 2002-12-19 at 18:48, Con Kolivas wrote:
>> > osdl, contest, tunable - starvation limit on 2.5.52-mm1
>>
>> Con, curiously, what is this OSDL hardware like?
>>
>> One thing I always liked about your Contest runs were you did them on
>> your home machine, which was presumably fairly run-of-the-mill so we
>> could keep an eye on the low-end desktop machines.
>>
>> 	Robert Love
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+BmmrF6dfvkL3i1gRApCRAJ96mtrpTCap5JoCQAX6UB3O39y3bgCcDoXM
XMa0Pz9Ldrdir9LQ4Qj83pI=
=CmgE
-----END PGP SIGNATURE-----
