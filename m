Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133118AbRAFV1I>; Sat, 6 Jan 2001 16:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133116AbRAFV06>; Sat, 6 Jan 2001 16:26:58 -0500
Received: from tweetie.comstar.net ([130.205.120.2]:16777 "EHLO
	tweetie.comstar.net") by vger.kernel.org with ESMTP
	id <S131350AbRAFV0t>; Sat, 6 Jan 2001 16:26:49 -0500
Date: Sat, 6 Jan 2001 16:25:13 -0500 (EST)
From: Gregory McLean <gregm@comstar.net>
To: Leslie Donaldson <donaldlf@i-55.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Major Failure  2.4.0-test12 Alpha
In-Reply-To: <3A38E509.1030402@i-55.com>
Message-ID: <Pine.LNX.4.30.0101061619030.30939-100000@tweetie.comstar.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2000, Leslie Donaldson wrote:

> Hello,
>   Just writing in to report a bug in 2.4.0-test12.
> Hardware:
>   PCI-Matrox_Mill
>   PCI-Adaptec 39160 / 160M scsi card
>   PCI-Generic TNT-2 card
>   PCI-Sound blaster -128 (es1370)
>
> CPU 21164a - Alpha

I'm also seeing this on 2.4.0 proper with almost the same hardware:
 SCSI storage controller: Adaptec AIC-7881U (rev 01) (aic71xxxx driver)
VGA compatible controller: Matrox Graphics, Inc. MGA 1064SG [Mystique]
(rev 03)
SB Vibra16X sound card.

I swap to scsi as the ide performance on this board just blows, I get into
a heavy swap situation and *boom* deadlocked.

>
> Problem:
>   There is a race condition in the aic7xxxx driver that causes the
> kernel to lock up.
> I don't have a kernel dump yet as the machine reported by it'self..
> This problem has been easy to reproduce. ergo about 3 crashes a day.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
