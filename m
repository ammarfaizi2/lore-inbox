Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262935AbRE1D34>; Sun, 27 May 2001 23:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262940AbRE1D3r>; Sun, 27 May 2001 23:29:47 -0400
Received: from server1.cosmoslink.net ([208.179.167.101]:5459 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S262935AbRE1D3j>; Sun, 27 May 2001 23:29:39 -0400
Message-ID: <016a01c0e726$61504d40$52a6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: "Miquel van Smoorenburg" <miquels@cistron-office.nl>,
        <linux-kernel@vger.kernel.org>
Cc: "Mark Hahn" <hahn@coffee.psychology.mcmaster.ca>,
        "Jaswinder Singh" <jaswinder.singh@3disystems.com>
In-Reply-To: <01052622193100.01317@linux.zuhause.de> <00a101c0e642$4f0791a0$52a6b3d0@Toshiba> <20010527224045.B3556@metastasis.f00f.org> <00c701c0e6d8$2b28ea40$4aa6b3d0@Toshiba> <9erttn$cak$1@ncc1701.cistron.net>
Subject: Re: IDE Performance lack !
Date: Sun, 27 May 2001 20:29:17 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Miquel van Smoorenburg" <miquels@cistron-office.nl> wrote:

>
> Are you sure it is idle. It might be running something from cron-
> say 'updatedb' or similar. That will cause a lot of disk i/o,
> and _ofcourse_ performance will be bad then - the machine is
> doing a lot of other things.
>

I am the only user who use my linux boxes , i never use cron , and i have no
relation with database at all.

> It might also be that you don't have enough memory and the
> machine is swapping itself to death. Running netscape or
> mozilla perhaps? These are known to blow themselves up to
> 50-100 MB (!). That will cause the exact symptoms you're seeing.
>

I never go to X-Windows , i do all my work from console.

cat /proc/meminfo
                total:    used:    free:  shared: buffers:  cached:
Mem:  114475008 111816704  2658304  5234688 68067328 24711168
Swap: 583954432  2654208 581300224
MemTotal:    111792 kB
MemFree:       2596 kB
MemShared:     5112 kB
Buffers:      66472 kB
Cached:       24132 kB
SwapTotal:   570268 kB
SwapFree:    567676 kB

>
> 2.4.2 isn't all that good either.. 2.4.x doesn't have VM sorted
> out just yet
>

may be this problem of VM as suggested by Mark Hahn.

Thank you,

Jaswinder.
--
These are my opinions not 3Di.


