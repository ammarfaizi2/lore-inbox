Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318502AbSIBV0w>; Mon, 2 Sep 2002 17:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318501AbSIBV0w>; Mon, 2 Sep 2002 17:26:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36360 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318487AbSIBV0v>; Mon, 2 Sep 2002 17:26:51 -0400
Date: Mon, 2 Sep 2002 14:39:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: aebr@win.tue.nl, <linux-kernel@vger.kernel.org>,
       <linux-raid@vger.kernel.org>, <neilb@cse.unsw.edu.au>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
In-Reply-To: <UTC200209022127.g82LR3g12738.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0209021437310.1374-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2 Sep 2002 Andries.Brouwer@cwi.nl wrote:
> 
> Compare it with mounting.

NO.

The point about backwards compatibility is that things WORK.

There's no point in comparing things to how you _want_ them to work. The
only thing that matters for bckwards compatibility is how they work
_today_.

And your suggestion would break every single installation out there. Not 
"maybe a few".  Every single one.

(yeah, you could find some NFS-only setup that doesn't break. Big deal).

And backwards compatibility is extremely important. 

		Linus

