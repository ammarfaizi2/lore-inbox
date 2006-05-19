Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWESR23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWESR23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 13:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWESR23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 13:28:29 -0400
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:59855 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751407AbWESR23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 13:28:29 -0400
Message-ID: <446DFF25.4020301@comcast.net>
Date: Fri, 19 May 2006 13:23:49 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: "Dr. David Alan Gilbert" <linux@treblig.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Stealing ur megahurts (no, really)
References: <446D61EE.4010900@comcast.net> <20060519112218.GE19673@gallifrey>
In-Reply-To: <20060519112218.GE19673@gallifrey>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Dr. David Alan Gilbert wrote:
> * John Richard Moser (nigelenki@comcast.net) wrote:
> 
>> Scrambling for an old machine is ridiculous.  Down-clocking makes sense
>> because you can adjust to varied levels; but it's difficult and usually
>> infeasible.  Pulling memory and mix and matching is not much better.
> 
> <...>
> 
>> This brings the idea of a cpumhz= parameter to adjust CPU clock rate.
>> Obviously we can't do this directly, as convenient as this would be; but
>> the idea warrants some thought, and some thought I gave it.  What I came
>> up with was simple:  Adjust time slice length and place a delay between
>> time slices so they're evenly spaced.
> 
> <...>
> 
> Hi John,
>   While cpu downclocking helps a bit, it would be hopelessly inaccurate
> for figuring out if your app would run fast enough on the given
> ancient machine.  A lot else has happened to the world since the days
> of the 200MHz CPU:
>     * Faster memory
>     * Larger caches
>     * Faster PCI busses
>     * Instruction set additions (various more levels of SSE etc)
>     * Faster discs
>     * Changes to the CPU architecture/implementation
> 

Skews and fuzz.  Imperfections, but at least we get a general idea.  ;)

> Still, it would be interesting to see the difference in performance
> of a downclocked modern processor and its 10 year old clock equivalent.
> 

Yes.  Too bad CPUs can't be uniformly underclocked by design; they have
at most 3-5 different levels of CPU frequency you can pick from at run time.

> Dave
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

iQIVAwUBRG3/Iws1xW0HCTEFAQIjJg//Z/IGDjhXqE9Cca7LCcnHBCcQ8Rts7moW
L0e1sCb6zrNWBTWo5h6OrzAJh5aTzeeciKpDufkuvvR+BREchiCTIm61IxokHCCS
2EQ8qfDJWD6ZkOi42tt4t/LftFaUbu7zxpalf5hA5qbCid1CjdqEiYZREDaDbqrf
uPNVk/w8TTaK5B8/+xWAxSNCnslGW7LRsYkLoQw2eTM4xKcNf4L76rCj/0SXoMcm
v56tx40CsfFtqzK5D+4y80hMzqGQ+ll3aenkgZIaD61rhcGL/QZPPAGC3F3rg+94
2iyaimu9582m6P9sdFHVrYVfCqLg8AKOIammBFxwPPmFaqaLeIjmsoQ5T+QMJbLJ
JZlsTFLG3FeeXuwGEOlO+dqZLKkF3ubfveFi3iUMkJkv7QnBbPAMRVwQL0Evl3WW
Ltegi6b8QxriFhNrkNAVv9L4IlhQkhGe4sff3xQNj3ZBms1RW85QhDDDUBX5eNHo
G8/Xdd9QcAVEBKt+welYsYcMS366dXir4STq9wANhks3S6sSWJUpEA5RrF8s2fN7
aNCWvO14sl9dscI4+w1vGQB9eGFcfIYWf+M1doQyKJgtx+bVRiE+mEWW2SZoKPCT
oTCEhPNOJenxVV6zqOsQT0wjyhRyONbwQJiv0sMr+9PLCe8A7u9VHUvOoQQ6bQOA
oBFc3EGABK4=
=dCD2
-----END PGP SIGNATURE-----
