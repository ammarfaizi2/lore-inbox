Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269157AbRHBVMg>; Thu, 2 Aug 2001 17:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269155AbRHBVM0>; Thu, 2 Aug 2001 17:12:26 -0400
Received: from [64.1.233.146] ([64.1.233.146]:7361 "EHLO windmill.gghcwest.com")
	by vger.kernel.org with ESMTP id <S269154AbRHBVMK>;
	Thu, 2 Aug 2001 17:12:10 -0400
Date: Thu, 2 Aug 2001 14:11:21 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@heat.gghcwest.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.3.95.1010802165949.7742A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0108021409100.21298-100000@heat.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Aug 2001, Richard B. Johnson wrote:

> Well I don't have any such problems here. I wrote this script
> from your instructions. I don't know if you REALLY wanted all
> the file content to go out to the screen, but I wrote it explicitly.

[snip]

> Script started on Thu Aug  2 16:50:47 2001
> # ps -laxw | grep pause
>    140     0    16     1  -1 -20    712    40 pause       S < ?   0:00 (bdflush) te
>      0     0  7433     1   9   0 321056 137808 pause       S    1  0:02 /tmp/try
>      0     0  7631  7626  19   0    844   240             R   p0  0:00 grep pause
> # cat /proc/meminfo
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  328048640 326234112  1814528        0  4255744 173219840
> Swap: 1069268992 189992960 879276032
                             ^^^^^^^^^
You still have almost 1GB of swap left.  I mean use all the memory in your
box, RAM + swap.

As I said, I expect degraded performance but not a complete meltdown.

-jwb

