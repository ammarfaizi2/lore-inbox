Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131525AbRCXA4R>; Fri, 23 Mar 2001 19:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131526AbRCXA4I>; Fri, 23 Mar 2001 19:56:08 -0500
Received: from jalon.able.es ([212.97.163.2]:61131 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131525AbRCXA4E>;
	Fri, 23 Mar 2001 19:56:04 -0500
Date: Sat, 24 Mar 2001 01:55:15 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-3.0 warnings
Message-ID: <20010324015515.C10781@werewolf.able.es>
In-Reply-To: <20010323162956.A27066@ganymede.isdn.uiuc.edu> <Pine.LNX.4.31.0103231433380.766-100000@penguin.transmeta.com>, <Pine.LNX.4.31.0103231433380.766-100000@penguin.transmeta.com>; <20010323235909.C3098@werewolf.able.es> <3ABBED86.3B7ED60B@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3ABBED86.3B7ED60B@uow.edu.au>; from andrewm@uow.edu.au on Sat, Mar 24, 2001 at 01:42:46 +0100
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.24 Andrew Morton wrote:
> "J . A . Magallon" wrote:
> > 
> >  The same is with that ugly out: at the end
> > of the function. Just change all that 'goto out' for a return.
> 
> Oh no, no, no.  Please, no.
> 
> Multiple return statements are a maintenance nightmare.
> 

Well, I do not want this to restart a religion war.

The real thing is: gcc 3.0 (ISO C 99) does not like that practice
(let useless things there for someday using them ?). And there can be
other languaje issues also (I'm just thinkin of some issues with case and
no default:) And gcc-3 is what we will
have to live with. I suppose people will like to see a kernel build
without tons of wanings. They hide real errors.

I think its a good thing to decide what to do (and start doing), than wait
until gcc2.95 is buried.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.2-ac22 #3 SMP Fri Mar 23 02:06:00 CET 2001 i686

