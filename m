Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129884AbQLUKXn>; Thu, 21 Dec 2000 05:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130150AbQLUKXd>; Thu, 21 Dec 2000 05:23:33 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:40014 "EHLO
	amsmta01-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129884AbQLUKXS>; Thu, 21 Dec 2000 05:23:18 -0500
Date: Thu, 21 Dec 2000 12:00:04 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kapm-idled : is this a bug?
In-Reply-To: <20001220101142.A6234@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0012211158170.12934-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > What's the problem with using PID 0 as the idle task ? That's 'standard'
> > with OS'ses that display the idle task.
> 
> Linux has already another thread with pid 0, called "swapper" which is
> in fact idle. kidle-apmd is different beast.

Agree that it is different. But it confuses people to have two
idle-tasks. I suggest that we throw it one big pile, unless having a
separate apm idle task has a purpose. 

> 								Pavel


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
