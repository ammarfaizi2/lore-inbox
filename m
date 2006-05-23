Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWEWBjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWEWBjT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 21:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWEWBjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 21:39:19 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:25778 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751249AbWEWBjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 21:39:19 -0400
Message-ID: <447266A7.8080100@comcast.net>
Date: Mon, 22 May 2006 21:34:31 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
References: <446E6A3B.8060100@comcast.net>	 <1148132838.3041.3.camel@laptopd505.fenrus.org>	 <446F3483.40208@comcast.net> <20060522010606.GC25434@elf.ucw.cz>	 <44712605.4000001@comcast.net> <20060522083352.GA11923@elf.ucw.cz>	 <4471E77F.1010704@comcast.net> <1148346316.3100.6.camel@laptopd505.fenrus.org>
In-Reply-To: <1148346316.3100.6.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
> On Mon, 2006-05-22 at 12:31 -0400, John Richard Moser wrote:
>> It is still possible that ARCH_STACK_RANDOM_BITS_DEFAULT breaks things.
>>  The current kernel default broke emacs at first I heard;
> 
> hearsay.. where did you hear this and what exact randomization was this?
> 

Sorry, I googled it, you were talking about brk() randomization (which I
STILL want to see!  :D)

http://lkml.org/lkml/2005/1/28/29

> 
>>  I believe we
>> started with 64KiB of stack randomization and then upped it to 8MiB when
>> emacs was fixed.
> 
> this is new information to me, I find this really really hard to believe
> as true but maybe you have information I don't have...

See this is why I said "I believe..."  :)

> 
> 
> 
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRHJmpQs1xW0HCTEFAQLX9Q//Rm0CvdLkPSq0UCLot9Mqyuj4REVwaGrV
VwJOGJgElyE/RFqu5MI8ab8CV7WUgKiV/wWrxyrfXRpW4uuYbedIsXAw8tzlJq/c
o+4FLVQBS+cXJ96VXIsHLIConlF21pXBZDzBFHHwfSsUsmbvgeJ0WavC3x3N7y6B
Bq4/RfVmf6yEECGSemoApzpbMR01anK6/nc1t0P9iMpsK5tlE9Q7r4/pB3wyRVmY
66GKAbcC4gU9CHtuu2e158/FCQXcfVZ1nFvKWGZyPWGAZAEiGazrMM5iv962EHX3
bqHKcMhr6BxsQt6LG7jzplg6YMDppqqWtiiIUfVJSnW65k1a2AmdGAEi0ZIe7IDm
T/YJRJqi54NOcI+UJ4FcODdlxfZ2EiVXNY22sf9wpn1lQpWt1TX4pbsaHjHVlLB7
8pBQzHSD+P9rDJ0eXfAC+0Vi0V/K1Yna/qhtdEnX2pp08zc2rdC6hu466MGWsH1u
vzD4772nWekd/c9Yby2BXbq+lwXHNA5iIwLBPA/NQwmSENFCdYhIFSrIOBjctQ1W
u85q3dhtFfXhTdwRdjfYtpoiYGIDx4l0wUohHPNLh5sD7NC81EtDOHm/WZfx2C1G
NAWsWkDPntxUpUcuSm+3nl3zDoPYPSMRiztwbWvm0BEdpn2uDyO0v5fMWdenpvMN
sn7wkuMaTlQ=
=OLQP
-----END PGP SIGNATURE-----
