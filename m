Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262020AbREYXQ2>; Fri, 25 May 2001 19:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262022AbREYXQS>; Fri, 25 May 2001 19:16:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5892 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262020AbREYXQK>; Fri, 25 May 2001 19:16:10 -0400
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
To: riel@conectiva.com.br (Rik van Riel)
Date: Sat, 26 May 2001 00:13:13 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105251919480.10469-100000@duckman.distro.conectiva> from "Rik van Riel" at May 25, 2001 07:20:20 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E153Qld-0007Df-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 25 May 2001, Linus Torvalds wrote:
> > On Fri, 25 May 2001, Rik van Riel wrote:
> > >
> > > OK, shoot me.  Here it is again, this time _with_ patch...
> >
> > I'm not going to apply this as long as it plays experimental games with
> > "shrink_icache()" and friends. I haven't seen anybody comment on the
> > performance on this,
> 
> Yeah, I guess the way Linux 2.2 balances things is way too
> experimental ;)

Compared to the 2.0 performance - yes. 2.0 is faster than 2.2 is twice the
speed of 2.4 starting X and the session apps on my MediaGX box with 64Mb

But Linus is right I think - VM changes often prove 'interesting'. Test it in
-ac , gets some figures for real world use then plan further


