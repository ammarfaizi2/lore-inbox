Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318846AbSICR5q>; Tue, 3 Sep 2002 13:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318898AbSICR5n>; Tue, 3 Sep 2002 13:57:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26536 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318846AbSICR5K>;
	Tue, 3 Sep 2002 13:57:10 -0400
Date: Tue, 3 Sep 2002 20:05:48 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <Pine.LNX.4.44.0209031858090.10770-100000@boris.prodako.se>
Message-ID: <Pine.LNX.4.44.0209032004380.4252-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Sep 2002, Tobias Ringstrom wrote:

> > (allowing -10 might be too much of a stretch.)
> 
> Why?  If it's using more than 50% CPU, the prio will be the same as a
> zero-niced interactive process.

well, perhaps -10 could also be allowed.

does -10 make it equivalent to the 2.4 behavior? Could you somehow measure
the priority where it's still acceptable? Ie. -8 or -9?

> The minimum user nice value might be a good candidate for a new
> rlimit...

yes.

	Ingo

