Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318519AbSIBWHD>; Mon, 2 Sep 2002 18:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318503AbSIBWHD>; Mon, 2 Sep 2002 18:07:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61706 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318497AbSIBWHC>; Mon, 2 Sep 2002 18:07:02 -0400
Date: Mon, 2 Sep 2002 15:06:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Thunder from the hill <thunder@lightweight.ods.org>
cc: Andries.Brouwer@cwi.nl, <aebr@win.tue.nl>, <linux-kernel@vger.kernel.org>,
       <linux-raid@vger.kernel.org>, <neilb@cse.unsw.edu.au>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
In-Reply-To: <Pine.LNX.4.44.0209021542590.3270-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0209021501080.1401-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2 Sep 2002, Thunder from the hill wrote:
> 
> Why not the faraway goal: no partition tables any more? They're annoying.

Yeah, users and real life is annoying.

Guys, Linux is not a research project. Never was, never will be. If you
want to have a research project that does things the way people think they
should be done (as opposed to real life and being practical), look at Hurd
and look at a lot of other projects. But don't look at Linux.

Partition tables are a fact of life. And they are a fundamental part to 
being able to parse what the disk contains. 

Sure, you can do it in user space too. And you can do TCP in user space.  
But some things are just fairly fundamental to the working of the system.  
The disk and filesystem layout is one such thing. It had better "just
work".

		Linus

