Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318735AbSIKN65>; Wed, 11 Sep 2002 09:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318768AbSIKN65>; Wed, 11 Sep 2002 09:58:57 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:35600
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318735AbSIKN65>; Wed, 11 Sep 2002 09:58:57 -0400
Subject: Re: [PATCH] Read-Copy Update 2.5.34
From: Robert Love <rml@tech9.net>
To: dipankar@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Andrea Arcangeli <andrea@suse.de>,
       Paul McKenney <paul.mckenney@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020911175011.D28198@in.ibm.com>
References: <20020911164940.C28198@in.ibm.com>
	<Pine.LNX.4.44.0209111323360.12332-100000@localhost.localdomain> 
	<20020911175011.D28198@in.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Sep 2002 10:03:28 -0400
Message-Id: <1031753011.950.106.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-11 at 08:20, Dipankar Sarma wrote:

> 			vanilla-2.5.34	rcu_poll-2.5.34
> 			--------------  ---------------
> 80 , 40 , 		1.593		1.569
> 112 , 40 , 		1.544		1.554
> 144 , 40 , 		1.595		1.552
> 176 , 40 , 		1.568		1.605
> 198 , 40 , 		1.562		1.577
> 230 , 40 , 		1.563		1.583
> 244 , 40 , 		1.671		1.638
> 
> Not sure how reliable these numbers are.

And how bad is the performance drop from 2.5.34-preempt to
2.5.34-preempt-rcu?

I am glad you guys support kernel preemption (not that you have a chance
at this point) but I hope it was not an afterthought.

	Robert Love

