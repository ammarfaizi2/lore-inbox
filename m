Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318529AbSIBVr4>; Mon, 2 Sep 2002 17:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318526AbSIBVr4>; Mon, 2 Sep 2002 17:47:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54537 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318503AbSIBVrz>; Mon, 2 Sep 2002 17:47:55 -0400
Date: Mon, 2 Sep 2002 15:00:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: aebr@win.tue.nl, <linux-kernel@vger.kernel.org>,
       <linux-raid@vger.kernel.org>, <neilb@cse.unsw.edu.au>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
In-Reply-To: <UTC200209022141.g82LfMV21308.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0209021459030.1401-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2 Sep 2002 Andries.Brouwer@cwi.nl wrote:
> 
> No, my suggested changes would not break a single Linux installation
> in the world.

.. by making your suggested behaviour not be used. Yes.

But if that is the case, then we _still_ need to fix the media change and 
partition read issue. Right? Which brings back _all_ my points for why it 
should be done at open time, and by the generic routine. Agreed?

		Linus

