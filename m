Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267047AbSLNEdY>; Fri, 13 Dec 2002 23:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbSLNEdY>; Fri, 13 Dec 2002 23:33:24 -0500
Received: from windsormachine.com ([206.48.122.28]:22537 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S267047AbSLNEdX>; Fri, 13 Dec 2002 23:33:23 -0500
Date: Fri, 13 Dec 2002 23:41:11 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: GrandMasterLee <masterlee@digitalroadkill.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <1039827325.31718.27.camel@UberGeek>
Message-ID: <Pine.LNX.4.33.0212132319280.29293-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Dec 2002, GrandMasterLee wrote:

> there. On my quad P4 Xeon 1.6Ghz with 1M L3 cache, I can compile a
> kernel in about 35 seconds. Mind you that's my own config, not
> *everything*. On a dual athlon MP at 1.8 Ghz, I get about 5 mins or so.
> Both are running with make -jx where X is the saturation value.

Something seems odd about the athlon MP time, I've got a celeron 533
with slow disks that does a pretty standard make dep ; make of 2.4.20 in
7m05, which is not that much different considering it's a third the speed,
and one cpu instead of two.

The single P4/2.53 in another machine can haul down in 3m17s

Guess our kernel .config's or version must vary greatly.

Mike

