Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264532AbTIJFH7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 01:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbTIJFH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 01:07:58 -0400
Received: from dyn-ctb-203-221-72-196.webone.com.au ([203.221.72.196]:15630
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S264532AbTIJFHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 01:07:46 -0400
Message-ID: <3F5EB194.2020102@cyberone.com.au>
Date: Wed, 10 Sep 2003 15:07:32 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Tony Jones <sir_tez@softhome.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm5 and Warcraft III - WineX
References: <1063169563.21739.1.camel@thelight.sir-tez.org>
In-Reply-To: <1063169563.21739.1.camel@thelight.sir-tez.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tony Jones wrote:

>In my testing of recent kernels 2.6.0-test5 and 2.6.0-test4-mm4 (mm6
>wouldn't cooperate with X for some reason and I didn't do much
>investigation) I've experied an easily replicable and highly annoying
>problem with Warcraft III and WineX 3.1 (prebuilt).
>
>After playing 1 or 2 games, or leaving the game idle in the chat room,
>the sound will eventually start to stutter and chop badly.  In the
>presence of this incredibly bad sound, the mouse and game respond just
>fine (kudos to the scheduler on that point).  Considering the game is
>played in "real-time" and is full of audio cues I hate to imagine that
>Con's scheduler will be the "official" scheduler of 2.6 without having
>this issue addressed.
>
>The kernels I use are tainted with nvidia's video drivers, 1.0.4496.  
>
>Nick's scheduler in 2.6.0-test4-mm5 seems to be the only thing capable
>of correcting this problem.  In general operation, mm5's scheduler
>seems better at handling about everything I threw at it, with a rare
>xmms skip once in a week of use.
>
>I'm not a developer but I'd love some feedback and or questions to
>help figure out why this happens with Con's scheduler patches in mm4
>and test5 to help improve 2.6.0 altogether.
>

Actually, I'd love some feedback from you.
Use this: http://www.kerneltrap.org/~npiggin/v14/sched-rollup-v14.gz
It will apply against 2.6.0-test4 or test5 (not mm). See how you go.

Thanks


