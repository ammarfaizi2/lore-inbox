Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313734AbSDHTEE>; Mon, 8 Apr 2002 15:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313735AbSDHTED>; Mon, 8 Apr 2002 15:04:03 -0400
Received: from kura.mail.jippii.net ([195.197.172.113]:17322 "HELO
	kura.mail.jippii.net") by vger.kernel.org with SMTP
	id <S313734AbSDHTEC>; Mon, 8 Apr 2002 15:04:02 -0400
Date: Mon, 8 Apr 2002 22:06:12 +0300
From: Anssi Saari <as@sci.fi>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is enabled
Message-ID: <20020408190612.GA19419@sci.fi>
In-Reply-To: <20020408154732.GA10271@sci.fi> <Pine.LNX.3.96.1020408133036.22155A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2002 at 01:35:35PM -0400, Bill Davidsen wrote:
>   Okay, this is good information. At the risk of asking a dumb question,
> are you sure that both the burner and the source drive ar using DMA?

I'm fairly certain. I can read that test image at ~37MB/s and 35% CPU,
which can't be PIO. The CD writer reads at ~3.7MB/s and 3% CPU usage.

> that they are on separate cables (controllers)?

Yes. Two HDs, one writer, all on different channels. The other HD is on
the motherboards Promise 20265 "raid" controller.

>   This would be a good question for the CD writing list,
> cdwrite@other.debian.org.

I tried that some time ago. So far, this is a sort of repetition of
that. Joerg Schilling suggested that maybe I don't have DMA on or the
reader and writer are on the same cable. Other discussion was off topic...

In fact, I've also had this conversation from the other point of view
with someone else, who  was asking about this same problem in the finnish
Linux group, sfnet.atk.linux. Now I have the same LG CD writer, the same
VIA KT133A chipset, the same problem and the same discussion... I'd be
amused if the problem weren't still unresolved.

I decided to post here after I tried FreeBSD, didn't have a problem
and thus it seemed likely that this is a Linux specific problem. 

I think I'll try to put together another system and see what happens
there. I wonder if SGI's kernprof thing would be useful with this.
I'll try that too, when I have the time.
