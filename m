Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318501AbSIBVo1>; Mon, 2 Sep 2002 17:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318503AbSIBVo1>; Mon, 2 Sep 2002 17:44:27 -0400
Received: from pD952A8C0.dip.t-dialin.net ([217.82.168.192]:3969 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318501AbSIBVoZ>; Mon, 2 Sep 2002 17:44:25 -0400
Date: Mon, 2 Sep 2002 15:48:54 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andries.Brouwer@cwi.nl, <aebr@win.tue.nl>, <linux-kernel@vger.kernel.org>,
       <linux-raid@vger.kernel.org>, <neilb@cse.unsw.edu.au>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
In-Reply-To: <Pine.LNX.4.44.0209021437310.1374-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209021544460.3270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2 Sep 2002, Linus Torvalds wrote:
> The point about backwards compatibility is that things WORK.
> 
> There's no point in comparing things to how you _want_ them to work. The
> only thing that matters for bckwards compatibility is how they work
> _today_.
> 
> And your suggestion would break every single installation out there. Not 
> "maybe a few".  Every single one.
> 
> (yeah, you could find some NFS-only setup that doesn't break. Big deal).
> 
> And backwards compatibility is extremely important. 

dep_bool '  New mountalike partitioning code' CONFIG_PARTMOUNTING CONFIG_EXPERIMENTAL CONFIG_WHATEVER

Or, since we're talking about the future:

<bool name="PARTMOUNTING">
 <title>
  New mount-alike partitioning code
 </title>
 <dep name="EXPERIMENTAL" sense="include" />
 <dep name="WHATEVER" sense="exclude" />
</bool>

See? New Deal is for the ones that were annoyed by the old one.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

