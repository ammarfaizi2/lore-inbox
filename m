Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132218AbRC1BP4>; Tue, 27 Mar 2001 20:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132244AbRC1BPq>; Tue, 27 Mar 2001 20:15:46 -0500
Received: from mpdr0.milwaukee.wi.ameritech.net ([206.141.239.126]:8837 "EHLO mailhost.mil.ameritech.net") by vger.kernel.org with ESMTP id <S132218AbRC1BPg>; Tue, 27 Mar 2001 20:15:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: james <jdickens@ameritech.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Ideas for the oom problem
Date: Tue, 27 Mar 2001 19:39:13 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.21.0103272151580.8261-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.21.0103272151580.8261-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Message-Id: <01032719391302.32154@friz.themagicbus.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 March 2001 18:52, Rik van Riel wrote:
> On Tue, 27 Mar 2001, james wrote:
> > Here are my ideas on how too deal with the oom situation,
> >
> > I propose a three prong approach too this problem
>
> Isn't that a bit much for an emergency situation that never
> even occurs on most systems ?
>
> Rik
> --
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
>
> 		http://www.surriel.com/
> http://www.conectiva.com/	http://distro.conectiva.com.br/


Given the amount, trafic on this mailing list and other places that this 
topic has created. Most of what I propose is not new it was proposed by 
others on this list.  Prong 1 is pretty much what oom_kill does with some 
slight canges and an addition of putting nice tasks too sleep, prong 2 is a 
variation of providing resources too root user, along with some resource 
accounting information that can be used both in the kernel and userland. If 
we don't get the right task, the problem continues too progress,. untill the 
right task is found or the system is brought too it knees.  Prong three 
provides a way too communicate with userland providing what aix does, and 
provides some level of being proactive instead of just be reactive where we 
have unto now been doing the wrong thing according too other readers of this 
list.  


james

