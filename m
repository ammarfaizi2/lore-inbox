Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131790AbQKSIba>; Sun, 19 Nov 2000 03:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132257AbQKSIbU>; Sun, 19 Nov 2000 03:31:20 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:59424 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S131790AbQKSIbM>; Sun, 19 Nov 2000 03:31:12 -0500
Date: Sun, 19 Nov 2000 10:01:01 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blindingly stupid 2.2 VM bug
Message-ID: <20001119100100.A54301@niksula.cs.hut.fi>
In-Reply-To: <Pine.LNX.4.21.0011182201250.11745-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011182201250.11745-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Sat, Nov 18, 2000 at 10:04:02PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2000 at 10:04:02PM -0200, you [Rik van Riel] said:
> Hi Alan,
> 
> here's a fix for a blindingly stupid bug that's been in
> 2.2 for ages (and which I've warned you about a few times
> in the last 6 months, and which I've even sent some patches
> for).
> 
> This patch should make 2.2 VM a bit more stable and should
> also fix the complaints from people who's system gets
> flooded by "VM: do_try_to_free_pages failed for process XXX"

Okay, I see those "VM: do_try_to_free_pages failed for process XXX" errors
as well (2.2.18pre19, uptime 8 days, machine had been idle for hours.
Then, all of a sudden, I get 30 times "VM: do_try_to_free_pages failed for
kswapd...", then 15 "VM: do_try_to_free_pages failed for xmms...", then
"VM: killing process xmms" and that repeats for ~10 processes including
X.) Never had problems with earlier 2.2.x.

My questions is: I saw Andrea's VM-global patch being recommended as a
solution for this problem, and I already compiled it in (although I
haven't booted into it yet). Should I use Rik's or Andrea's patch?

Is either of them going into 2.2.18?


-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
