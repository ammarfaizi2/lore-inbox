Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319466AbSH3HYo>; Fri, 30 Aug 2002 03:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319473AbSH3HYn>; Fri, 30 Aug 2002 03:24:43 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:63117 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319466AbSH3HYn>; Fri, 30 Aug 2002 03:24:43 -0400
To: Anssi Saari <as@sci.fi>
Cc: Sergio Bruder <sergio@bruder.net>, Andre Hedrick <andre@linux-ide.org>,
       vojtech@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: CD burning at 12x uses excessive CPU, although DMA is
 enabled
References: <200204092206.02376.roger.larsson@norran.net>
	<Pine.LNX.4.10.10204091320450.25275-100000@master.linux-ide.org>
	<20020414123935.GA6441@sci.fi> <20020830043346.GA5793@bruder.net>
	<87d6s0g9eq.fsf@plailis.homelinux.net> <20020830065142.GA10582@sci.fi>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <plail@web.de>
Date: Fri, 30 Aug 2002 09:27:04 +0200
In-Reply-To: <20020830065142.GA10582@sci.fi> (Anssi Saari's message of "Fri,
 30 Aug 2002 09:51:42 +0300")
Message-ID: <874rdcg62f.fsf@plailis.homelinux.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anssi!

* Anssi Saari writes:
>I doubt that's the problem. As I've said before, I don't have this huge
>slowdown problem if I plug the writer to a Promise pdc20265 or CMD649,
>neither of which supports DMA for ATAPI devices. These controllers
>however abort CD writing randomly so they are not a workaround... 

Well, they may very well just deal better with PIO modes.

>I also don't have your DAO vs. TAO problem.

Hmm.. you wrote that cdrdao gives the problem, but cdrecord
doesn't. And in a previous mail you wrote that you also have the
problems when writing audio CDs. Are you sure that you really used DAO
when using cdrecord? All other symptoms look very much like the big
blocksize problem.

regards
Markus

