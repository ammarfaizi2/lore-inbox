Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318159AbSG3AaS>; Mon, 29 Jul 2002 20:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318164AbSG3AaS>; Mon, 29 Jul 2002 20:30:18 -0400
Received: from zero.tech9.net ([209.61.188.187]:9738 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S318159AbSG3AaR>;
	Mon, 29 Jul 2002 20:30:17 -0400
Subject: Re: [PATCH] spinlock.h cleanup
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1027989053.929.263.camel@sinai>
References: <Pine.LNX.4.33.0207291725580.1722-100000@penguin.transmeta.com>
	 <1027989053.929.263.camel@sinai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 29 Jul 2002 17:33:39 -0700
Message-Id: <1027989220.1016.273.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 17:30, Robert Love wrote:

> On Mon, 2002-07-29 at 17:26, Linus Torvalds wrote:
> 
> > Hmm.. Why did you remove the gcc workaround? Are all gcc's > 2.95 known to 
> > be ok wrt empty initializers?
> 
> If I recall correctly, the fix was for older egcs compilers.

To better answer your question, I just checked and indeed it seems all
gcc's >= 2.95 are OK.

	Robert Love

