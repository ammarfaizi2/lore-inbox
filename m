Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318510AbSIBVjb>; Mon, 2 Sep 2002 17:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318503AbSIBVjb>; Mon, 2 Sep 2002 17:39:31 -0400
Received: from pD952A8C0.dip.t-dialin.net ([217.82.168.192]:897 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318497AbSIBVj3>; Mon, 2 Sep 2002 17:39:29 -0400
Date: Mon, 2 Sep 2002 15:43:56 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Andries.Brouwer@cwi.nl
cc: aebr@win.tue.nl, <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <linux-raid@vger.kernel.org>, <neilb@cse.unsw.edu.au>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
In-Reply-To: <UTC200209022127.g82LR3g12738.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0209021542590.3270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2 Sep 2002 Andries.Brouwer@cwi.nl wrote:
> [Yes, a shock, but very easy for people to add
>       blockdev --rereadpt /dev/foo
> (or a partx call) in some bootscripts.]

fdisk -r DEV -> read device's partition table

> The faraway goal is: no partition table reading in the kernel.

Why not the faraway goal: no partition tables any more? They're annoying.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

