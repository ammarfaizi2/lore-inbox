Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWGZQP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWGZQP5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 12:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWGZQP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 12:15:57 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:42209 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751057AbWGZQP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 12:15:57 -0400
Message-ID: <44C79539.4040506@comcast.net>
Date: Wed, 26 Jul 2006 12:15:53 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: gettimeofday(), clock_gettime(), timer_gettime()
References: <44C6D8CD.4040604@comcast.net> <p737j205r2q.fsf@verdi.suse.de>
In-Reply-To: <p737j205r2q.fsf@verdi.suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Andi Kleen wrote:
> John Richard Moser <nigelenki@comcast.net> writes:
> 
>>  - gettimeofday() is slow, or so they say, needing several milliseconds
>> to execute.
> 
> It's not generally true, only sometimes. Please don't spread FUD.
> 

http://lwn.net/Articles/192214/

"X is a big offender, apparently because the gettimeofday() call is
still too slow and maintaining time stamps with interval timers is faster."

Or so they say.  I'm not the one spreading FUD; amusingly it takes me
50uS to run gettimeofday().

> -Andi
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
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRMeVNQs1xW0HCTEFAQImUg//eHXZfdTjazbLZFFUFVSoaCafunFzZyB5
uVmEq7yDWwsWe2jWTj9g3L/CpTECaiIAbcErrOxo8tGjN9PvGjKhfBTO8QmQAw6P
/InXa/DlPYN+ZhHAhXaNiS8CHMlVdSL6PT5NSMtugkepgRdQ4OhjOWe3MNgvSfdJ
tmUdq/clqz7S1gnPg8UvGOjgtUAlh+1+/7F/mYHgJn84DnexC81apVhP99jqvQ3o
u4dVyqxbfPIGkPDkZuorKY8HKeVLD6qettK8fK01pz2wgwSrjl1q+rZm2BGzuyMw
AAFtgfL/Z1DlEroaNcjAPJI3C43D4idGxpmtut/+sDP7wqxZ5LafULzotQWNbwDl
zi0MAfMbPkigPE8eUaQigHWTM7omvGFdadJhwx6Xd3ZmP2KTs6pCVU0X/A6i4ae/
fO1VbSztcVtoSy3Bz2jRIp4TjW1xuucdchjsT5yskpdEeeMwToKRV0qBTu1tyCv9
INQ4ovWNDsPgVLFx4l8EpcVlnYGelaJLNpzt+7bEFLsrW/q3thzCHFr440Cc5h4G
7Ukvu5s/a4BbMa6vnVPbaek7S8tBCrcHixzttJcjiObnxicZxr2V81sviVDMlCmy
zMuPeASzurgo2n3tDAmIwxICMUmsYB8l4oce7f1LLK9PFeOrVBhcLJymPCh8on4z
HIreAI1tj+Q=
=i75z
-----END PGP SIGNATURE-----
