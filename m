Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280971AbRKCPn6>; Sat, 3 Nov 2001 10:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280973AbRKCPnt>; Sat, 3 Nov 2001 10:43:49 -0500
Received: from B5820.pppool.de ([213.7.88.32]:17421 "HELO Nicole.fhm.edu")
	by vger.kernel.org with SMTP id <S280971AbRKCPno>;
	Sat, 3 Nov 2001 10:43:44 -0500
Date: Sat, 3 Nov 2001 14:54:30 +0100 (CET)
From: degger@fhm.edu
Reply-To: degger@fhm.edu
Subject: Re: 2.4.12 and memory (Swap<->Cached)
To: andy@spylog.ru
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011103153501.A26174@spylog.ru>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20011103140903.692EC6E01@Nicole.fhm.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3 Nov, Andrey Nekrasov wrote:

>         total:    used:    free:  shared: buffers:  cached:
> Mem:  2108588032 2105348096  3239936        0    69632 708489216
> Swap: 4293378048 156639232 4136738816
> MemTotal:      2059168 kB
> MemFree:          3164 kB
> MemShared:           0 kB
> Buffers:            68 kB
> Cached:         691876 kB
> SwapCached:          8 kB
> Active:         490884 kB
> Inactive:       201068 kB
> HighTotal:     1703872 kB
> HighFree:         1152 kB
> LowTotal:       355296 kB
> LowFree:          2012 kB
> SwapTotal:     4192752 kB
> SwapFree:      4039784 kB
> Why use swap, if "Cached" (it is disk cache?) 691876 kB?

I have a different problem with this figures. Shouldn't
Active+Inactive+Cached+Buffers+MemFree == MemTotal?

In fact I was about to also post a cat of meminfo because
I'm having really poor interactive perfomance on my G4-500
with 2.4.14-pre5-ben0 and I think it's memory related. The
problems weren't that bad a few subreleases ago.

        total:    used:    free:  shared: buffers:  cached:
Mem:  261517312 252518400  8998912        0  1175552 66686976
Swap: 268427264 79831040 188596224
MemTotal:       255388 kB
MemFree:          8788 kB
MemShared:           0 kB
Buffers:          1148 kB
Cached:          49420 kB
SwapCached:      15704 kB
Active:          49748 kB
Inactive:        60160 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255388 kB
LowFree:          8788 kB
SwapTotal:      262136 kB
SwapFree:       184176 kB

All the machine is running right now is the GNOME desktop, a mailreader
and a webbrowser as well as 4 terminals.

--
Servus,
       Daniel



