Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262497AbSKDQok>; Mon, 4 Nov 2002 11:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262689AbSKDQok>; Mon, 4 Nov 2002 11:44:40 -0500
Received: from mail.hometree.net ([212.34.181.120]:7640 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S262497AbSKDQoi>; Mon, 4 Nov 2002 11:44:38 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [lkcd-general] Re: What's left over.
Date: Mon, 4 Nov 2002 16:51:12 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <aq68i0$d6l$1@forge.intermeta.de>
References: <aq63kp$9j6$1@forge.intermeta.de> <Pine.LNX.4.44.0211041034330.16432-100000@ibm-ps850.purdueriots.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1036428672 16867 212.34.181.4 (4 Nov 2002 16:51:12 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 4 Nov 2002 16:51:12 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Finnegan <pat@purdueriots.com> writes:

>On Mon, 4 Nov 2002, Henning P. Schmiedehausen wrote:

>> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>>
>> >On Mon, 2002-11-04 at 14:45, Henning P. Schmiedehausen wrote:
>> >> Good! This means, people debugging the code have actually to think and
>> >> don't produce "turn on debugger, step here, there, patch a band aid,
>>
>> >Some of us debug hardware. Regardless of the nice theories about
>> >reviewing your code they don't actually work on hardware because no
>> >amount of code review will let you discover things like undocumented
>> >2uS deskew delays, or errors in DMA engines
>>
>> A debugger won't help you here either. A pci bus probe, a 'scope and a
>> logic analyzer do.
>>
>> (And experience, elbow grease, experience and a nice amount of ESP :-)
>> I do hate hardware. Had to debug too much of it (and just on
>> m68k/MCS-51 where the clock rates are low and the parts easy to
>> solder...).

>I find that hard to believe.  You're saying it's impossible to use a
>software debugger to debug the interface between the software and the

No. IMHO it is impossible to use a software debugger to catch 2uS
deskew delays or errors in DMA engines. That's what logic analyzers
are for. If you attach or fire up the debugger, the timing changes and
you're no longer testing the failure case but something different.

>(No Linus, I'm not pushing them, just stating my opinion.)

I am, BTW completely your opinion. Personally I find it horrid that
"the XIAFS resurrection" is winked through with "will be probably
accepted for the hack value" and LKCD is rejected with "bloat"
arguments.

But hey, it _is_ Linus' kernel and he may choose as he likes. I
e.g. run vendor kernels (for 2.4).

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
