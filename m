Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131529AbRACAP2>; Tue, 2 Jan 2001 19:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131837AbRACAPT>; Tue, 2 Jan 2001 19:15:19 -0500
Received: from carbon.btinternet.com ([194.73.73.92]:31153 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S131529AbRACAPH>; Tue, 2 Jan 2001 19:15:07 -0500
Date: Tue, 2 Jan 2001 23:44:14 +0000 (GMT)
From: davej@suse.de
To: "Giacomo A. Catenazzi" <cate@dplanet.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: Coppermine is a PIII or a Celeron? WINCHIP2/WINCHIP3D diff?
In-Reply-To: <3A523012.CF78B83D@dplanet.ch>
Message-ID: <Pine.LNX.4.21.0101022341010.23070-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Giacomo A. Catenazzi wrote:

> When working in cpu autoconfiguration I found some problems:
> What is the difference between MWINCHIP2 and MWINCHIP3D?
> I don't find differences in the sources

MWINCHIP3D is for the Winchip-2A and above, which have 3dnow!
instructions. Until recently it was using the 3dnow memcopy stuff.
It got disabled when the memcopy stuff was overhauled to give even
bigger wins on the Athlon. Which makes sense given that there are
a lot more Athlons out there than Winchips.

Who knows, maybe the old 3dnow! copy routine will make a comeback
in a future kernel just for Winchip-2As and above. Just needs someone
to find the time.

regards,

Davej.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
