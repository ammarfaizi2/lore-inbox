Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319108AbSHSX3G>; Mon, 19 Aug 2002 19:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319109AbSHSX3G>; Mon, 19 Aug 2002 19:29:06 -0400
Received: from mx2.elte.hu ([157.181.151.9]:33996 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319108AbSHSX3G>;
	Mon, 19 Aug 2002 19:29:06 -0400
Date: Tue, 20 Aug 2002 01:34:27 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: MAX_PID changes in 2.5.31
In-Reply-To: <1029799751.21212.0.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208200131590.7206-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20 Aug 2002, Alan Cox wrote:

> libc5 is very much 16bit pid throughout. It would make sense that our
> default (proc settable) pid max is 30000 still so that it only breaks
> stuff if you increase it

We can have the safe low value in 2.6 i think - it's not that the typical
2.6 kernel is expected to run tens of thousands of tasks.

	Ingo

