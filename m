Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131375AbRCHNca>; Thu, 8 Mar 2001 08:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131376AbRCHNcU>; Thu, 8 Mar 2001 08:32:20 -0500
Received: from falcon.etf.bg.ac.yu ([147.91.8.233]:8710 "EHLO
	falcon.etf.bg.ac.yu") by vger.kernel.org with ESMTP
	id <S131375AbRCHNcE>; Thu, 8 Mar 2001 08:32:04 -0500
Date: Thu, 8 Mar 2001 14:29:06 +0100 (CET)
From: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>
To: Oswald Buddenhagen <ob6@inf.tu-dresden.de>
cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: static scheduling - SCHED_IDLE?
In-Reply-To: <20010307202027.B27421@ugly.wh8.tu-dresden.de>
Message-ID: <Pine.LNX.4.20.0103081427040.3785-100000@falcon.etf.bg.ac.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> did "these" apply only to the tasks, that actually hold a lock?
> if not, then i don't like this idea, as it gives the processes
> time for the only reason, that it _might_ hold a lock. this basically 
> undermines the idea of static classes. in this case, we could actually
> just make the "nice" scale incredibly large and possibly nonlinear, 
> as mark suggested.

would it be possible to subqueue tasks that are holding a lock so that
they get some guaranteed amount of cpu and just leave other to be executed
when processor really idle?

lynx

