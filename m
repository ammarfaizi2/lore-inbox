Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWJLUg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWJLUg6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWJLUg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:36:57 -0400
Received: from alnrmhc11.comcast.net ([204.127.225.91]:3264 "EHLO
	alnrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750845AbWJLUg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:36:56 -0400
Message-ID: <452EA766.80307@comcast.net>
Date: Thu, 12 Oct 2006 16:36:54 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
References: <452E62F8.5010402@comcast.net> <452E9E47.8070306@nortel.com>	 <452EA441.6070703@comcast.net> <1160684954.3000.473.camel@laptopd505.fenrus.org>
In-Reply-To: <1160684954.3000.473.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
>> ther uniprocessor machines.
>> That's a load more descriptive :D
>>
>> 0.890 uS, 0.556uS/cycle, that's barely 2 cycles you know.  (Pentium M)
>> PPC performs similarly, 1 cycle should be about 1uS.
>>
>>> Chris
> 
> you have your units off; 1 cycle is 1 nS not 1 uS  (or 0.556 nS for the
> pM)

Ah, right right.  Nano is a billion, micro is a million.  How did I get
that mixed up.

So that's barely two THOUSAND cycles.  Which is closer to what I
expected (i.e., not instant)


> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRS6nZAs1xW0HCTEFAQImYQ/+Lmcd2zzOhtJHZ6AofBajWh7CEhqLCfqd
mQ09b95YPtDXEr0f5Uud69/v4+dE5gVh1ze68z4+15dFtfLfR7EuBJpXykoSDSGB
fMVhwd6COzN8l4Bl826tbH3jvNnX8jssLcCr/qNvtYA1pDntXjjFdPF0OHdU87Kr
KYODxIM69akjTALjYO4NinYZdhcJn++DkHfKtIfjL5qD9gc0VMe8EMj1bQo2Jz8T
FBpMtfz2JPcXq8CFYDz9fMREtrJQfpYYFMyG+MJHWiNpEWUXTy7Jg40q/k5Jhsf0
ReDh+FJDWGmtep938wTquIojhSu/WYNyyBjAXlWcLo08S1cl5BSLj0hD12sKXT6c
0FmqIZO44Pp6dBfoHxRrss6tljbsoTAmAf0ac4PLMciHJfidYvoAfWH++70i+4Wm
CtsQdRn0jY7Ws0vB3pVLA6IlpZ/D5OXE+ko7ntiOUDkiKynoUHz71h6WwtpCorF2
myUurBvHbL85VTCOegomy/5/6UcozFK2LovkjRN9jXoP2ZportXPIYL0ssrRnXN0
7GtS9Ye5Mu2+n88pk64HdKWg75uflZPAobfCBg1lt933wlXfpOwi7FKKuwTHP8vD
2IabVRcJEk2VnOgJDfQ5iSooN4XDFRIG+DjI3/7lzRDpLRpMiUBy91K7adi5u7ah
tx+izQjdo3c=
=HqrS
-----END PGP SIGNATURE-----
