Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130643AbRBEPwJ>; Mon, 5 Feb 2001 10:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135178AbRBEPvt>; Mon, 5 Feb 2001 10:51:49 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:25027 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S135177AbRBEPvi>; Mon, 5 Feb 2001 10:51:38 -0500
Message-ID: <3A7ECBFE.7C035F45@Home.net>
Date: Mon, 05 Feb 2001 10:51:26 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: LA Walsh <law@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x Shared memory question
In-Reply-To: <3A7E49C6.BE283336@sgi.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its supposed to, its too costly to calculate shared memory with the new VM
I'm told.

Shawn.

LA Walsh wrote:

> Another oddity -- I notice things taking alot more memory
> in 2.4.  This coincides with 'top' consistently showing I have 0 shared
> memory.  These two observations would have me wondering if I
> have somehow misconfigured my system to disallow sharing.  Note
> that /proc/meminfo also shows 0 shared memory:
>
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  525897728 465264640 60633088        0 82145280 287862784
> Swap: 270909440        0 270909440
> MemTotal:       513572 kB
> MemFree:         59212 kB
> MemShared:           0 kB
> Buffers:         80220 kB
> Cached:         281116 kB
> Active:          22340 kB
> Inact_dirty:    338996 kB
> Inact_clean:         0 kB
> Inact_target:        0 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       513572 kB
> LowFree:         59212 kB
> SwapTotal:      264560 kB
> SwapFree:       264560 kB
>
> Not that it seems unrelated, but I do have filesystem type shm
> mounted on /dev/shm as suggested for POSIX shared memory.
>
> --
> Linda A Walsh                    | Trust Technology, Core Linux, SGI
> law@sgi.com                      | Voice: (650) 933-5338
>
> --
> Linda A Walsh                    | Trust Technology, Core Linux, SGI
> law@sgi.com                      | Voice: (650) 933-5338
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
