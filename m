Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318265AbSHPJkd>; Fri, 16 Aug 2002 05:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318269AbSHPJkd>; Fri, 16 Aug 2002 05:40:33 -0400
Received: from smtp01.web.de ([194.45.170.210]:30736 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S318265AbSHPJkc>;
	Fri, 16 Aug 2002 05:40:32 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: ide-2.4.19-ac4.11.patch, late but stable
References: <Pine.LNX.4.10.10208152353190.12468-100000@master.linux-ide.org>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <plail@web.de>
Date: Fri, 16 Aug 2002 11:43:05 +0200
In-Reply-To: <Pine.LNX.4.10.10208152353190.12468-100000@master.linux-ide.org> (Andre
 Hedrick's message of "Fri, 16 Aug 2002 00:01:52 -0700 (PDT)")
Message-ID: <87fzxfxhp2.fsf@plailis.homelinux.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre!

* Andre Hedrick writes:
>Greetings Markus,

>It is a fair question of which I do not have a nice answer.  I am
>working on fresh atapi-packet-generic engine but it is not a joy.
>There are oddities like bus-phases or bus-states which their setup and
>feeding of the DMA engine requires a more eligant hammer.

OK, I see. It's just that I stumbled across the patch for DMA audio CD
reading and thought that you perhaps have something similiar for
writing bigger block sizes. 

>As much as I hate to concept of a DMA mempool, it looks like the
>direction to follow.  Games such as HOST<>DEVICE || feast<>famine of
>buffer streams appear to be the norm to push vast amounts of atapi-dma.
>The alternative is to have device level request queues and have the
>queues carry the SG or PRD list for that portion.
>I am open to suggestions for direction.

I have to admit that I do not even have an idea what you are talking
about. I just think that this is a major drawback for Linux. CD writers
are as fast as 48x nowadays and DVD writers start getting more popular,
too, just as doing c2scans. So it is quite disappointing that it doesn't
work flawlessly with Linux.

regards
Markus

