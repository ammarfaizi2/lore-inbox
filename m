Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282007AbRKVCWs>; Wed, 21 Nov 2001 21:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282011AbRKVCWi>; Wed, 21 Nov 2001 21:22:38 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:55432 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S282007AbRKVCW2>; Wed, 21 Nov 2001 21:22:28 -0500
Date: Wed, 21 Nov 2001 18:23:00 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: war <war@starband.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Swap vs No Swap.
In-Reply-To: <3BFC5A9B.915B77DF@starband.net>
Message-ID: <Pine.LNX.4.33.0111211813160.20514-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, war wrote:

> No swap = fastest possible solution.

assuming you can safely run without swap yes...

In many cases paging out processes you're not using can free up memoery 
for useful things like caching disk writes... 

for a significant number of people running without swap isn't an option. 

if you have fine grained control over how much of your memory is used by 
your apps then running without swap can be a resonable option...

  6:19pm  up 3 days,  5:15,  3 users,  load average: 0.44, 0.58, 0.61
53 processes: 51 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:  7.5% user, 17.6% system,  0.0% nice, 74.7% idle
Mem:   770844K av,  767476K used,    3368K free,     824K shrd,   80280K buff
Swap:       0K av,       0K used,       0K free                  134424K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 1076 squid     16   0  499M 499M  2108 R    23.0 66.3  2546m squid

 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli				       joelja@darkwing.uoregon.edu    
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


