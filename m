Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290103AbSBFLze>; Wed, 6 Feb 2002 06:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290433AbSBFLz0>; Wed, 6 Feb 2002 06:55:26 -0500
Received: from firewall.oeone.com ([216.191.248.101]:33039 "HELO
	mail.oeone.com") by vger.kernel.org with SMTP id <S290103AbSBFLzM>;
	Wed, 6 Feb 2002 06:55:12 -0500
Message-ID: <3C611CDC.6010503@oeone.com>
Date: Wed, 06 Feb 2002 07:09:00 -0500
From: Masoud Sharbiani <masouds@oeone.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: paule <paule@ilu.vu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap issue
In-Reply-To: <20020206042922.GA89628@oenone.stormclouds.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

paule wrote:

>Having just upgraded slackware8.0 (2.2 kernel)
>to using 2.5.2, (2.5.3 patch install failed looking for malloc.h)
>Im unable to use swap, despite it showing a success.
>
># dd if=/dev/zero of=/swap/swapfile bs=1024 count=131072
>13107+0 records in
>13107+0 records out
># mkswap -c /swap/swapfile
>Setting up swapspace version 1, size = 13414400 bytes
>
I'd do a sync before turning swap on  on a file if I were you.

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



