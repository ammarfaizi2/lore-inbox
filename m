Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261531AbSJDH5X>; Fri, 4 Oct 2002 03:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261532AbSJDH5X>; Fri, 4 Oct 2002 03:57:23 -0400
Received: from packet.digeo.com ([12.110.80.53]:49867 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261531AbSJDH5V>;
	Fri, 4 Oct 2002 03:57:21 -0400
Message-ID: <3D9D4B28.44625C91@digeo.com>
Date: Fri, 04 Oct 2002 01:02:48 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: szonyi calin <caszonyi@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5.40 DMA and mm issues
References: <20021004065223.24159.qmail@web40602.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2002 08:02:48.0617 (UTC) FILETIME=[6E0BA990:01C26B7C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

szonyi calin wrote:
> 
> ...
> Here is /proc/meminfo after killing the updatedb:
> MemTotal:       125576 kB
> MemFree:          5540 kB
> MemShared:           0 kB
> Buffers:         21092 kB
> Cached:          25124 kB
> SwapCached:       1888 kB
> Active:          15388 kB
> Inactive:        33268 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       125576 kB
> LowFree:          5540 kB
> SwapTotal:      248968 kB
> SwapFree:       246892 kB
> Dirty:              64 kB
> Writeback:           0 kB
> Mapped:           2512 kB
> Slab:            69712 kB
> Committed_AS:     3348 kB
> PageTables:        192 kB
> ReverseMaps:      2314

That looks reasonable for an updatedb run.
 
> hda: DMA disabled

This is probably why it's taking tons of system time.
