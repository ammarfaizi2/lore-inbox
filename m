Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132389AbRA0JqW>; Sat, 27 Jan 2001 04:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132415AbRA0JqM>; Sat, 27 Jan 2001 04:46:12 -0500
Received: from gadolinium.btinternet.com ([194.73.73.111]:17079 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S132389AbRA0Jp4>; Sat, 27 Jan 2001 04:45:56 -0500
Date: Sat, 27 Jan 2001 09:45:51 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Shawn Starr <Shawn.Starr@Home.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM]: Under 2.4.X hdparm displays device names backwards?
 ;)
In-Reply-To: <3A7296E1.43DDF06A@Home.com>
Message-ID: <Pine.LNX.4.31.0101270944180.26796-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jan 2001, Shawn Starr wrote:

> This is what the device names are:
> hda: FUJITSU MPE3064AT, ATA DISK drive
> hdb: WDC AC32500H, ATA DISK drive
> here's what they are with hdparm:
>  Model=UFIJST UPM3E60A4 T                      , FwRev=DE0--380,
>  Model=DW CCA2305H0                            , FwRev=210.H721,
>
> hehe, might wanna fix that ;-)

This is correct behaviour.
You want hdparm -i not hdparm -I which reads info from the drive
without doing endian changes.

regards,

Davej.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
