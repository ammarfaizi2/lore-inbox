Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbREMT7r>; Sun, 13 May 2001 15:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261880AbREMT7h>; Sun, 13 May 2001 15:59:37 -0400
Received: from jalon.able.es ([212.97.163.2]:12465 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S261854AbREMT73>;
	Sun, 13 May 2001 15:59:29 -0400
Date: Sun, 13 May 2001 21:59:20 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: [PATCH] eliminate a truckload of context switches
Message-ID: <20010513215920.A1437@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.33.0105081355290.363-100000@mikeg.weiden.de> <Pine.LNX.4.21.0105131320380.5468-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0105131320380.5468-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Sun, May 13, 2001 at 18:21:46 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.13 Rik van Riel wrote:
> On Tue, 8 May 2001, Mike Galbraith wrote:
> 
> > While running a ktrace enabled kernel (IKD), I noticed many useless
> > context switches.  The problem is that we continually pester kswapd/
> > kflushd at times when they can't do anything other than go back to
> > sleep.  As you'll see below, we do this quite a bit under heavy load.
> 
> I agree, both with your analysis that the context switches
> aren't needed and with the patch you sent to fix it.
> 
> Linus, if it isn't in the kernel yet, please put it in...
> 

If it matters, I have been running it on 2.4.4-ac8 and works fine...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.4-ac8 #1 SMP Sat May 12 01:16:37 CEST 2001 i686

