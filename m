Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290573AbSBFObF>; Wed, 6 Feb 2002 09:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290574AbSBFOaz>; Wed, 6 Feb 2002 09:30:55 -0500
Received: from ns1.intercarve.net ([216.254.127.221]:65193 "HELO
	ceramicfrog.intercarve.net") by vger.kernel.org with SMTP
	id <S290573AbSBFOap>; Wed, 6 Feb 2002 09:30:45 -0500
Date: Wed, 6 Feb 2002 09:27:19 -0500 (EST)
From: "Drew P. Vogel" <dvogel@intercarve.net>
To: paule <paule@ilu.vu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Swap issue
In-Reply-To: <20020206042922.GA89628@oenone.stormclouds.net>
Message-ID: <Pine.LNX.4.33.0202060926570.27274-100000@northface.intercarve.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the output of 'swapon -s'?

--Drew Vogel

On Wed, 6 Feb 2002, paule wrote:

>Having just upgraded slackware8.0 (2.2 kernel)
>to using 2.5.2, (2.5.3 patch install failed looking for malloc.h)
>Im unable to use swap, despite it showing a success.
>
># dd if=/dev/zero of=/swap/swapfile bs=1024 count=131072
>13107+0 records in
>13107+0 records out
># mkswap -c /swap/swapfile
>Setting up swapspace version 1, size = 13414400 bytes
># swapon /swap/swapfile
>swapon: /swap/swapfile: Success
># cat /proc/meminfo
>MemTotal:        61720 kB
>MemFree:          1896 kB
>MemShared:           0 kB
>Buffers:          8300 kB
>Cached:          30712 kB
>SwapCached:          0 kB
>Active:          25316 kB
>Inactive:        19688 kB
>HighTotal:           0 kB
>HighFree:            0 kB
>LowTotal:        61720 kB
>LowFree:          1896 kB
>SwapTotal:           0 kB
>SwapFree:            0 kB
>
>I've tried various kernel configurations, and it just doesn't
>want to work.
>
>(It was however working under 2.2.x)
>
>Any ideas?
>
>TIA,
>--
>Paul Edwards
>paule@ilu.vu
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



