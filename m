Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSGUWRE>; Sun, 21 Jul 2002 18:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSGUWRE>; Sun, 21 Jul 2002 18:17:04 -0400
Received: from mx2.elte.hu ([157.181.151.9]:45723 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S314811AbSGUWRD>;
	Sun, 21 Jul 2002 18:17:03 -0400
Date: Mon, 22 Jul 2002 00:19:05 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A1
In-Reply-To: <1027280334.1086.1027.camel@sinai>
Message-ID: <Pine.LNX.4.44.0207220018430.31713-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21 Jul 2002, Robert Love wrote:

> Ingo, looking over the FIXMEs in the tty layer I think they are
> definitely _broke_.  At least some of these paths have no global
> synchronization now.  Someone really needs to go through this cruft and
> clean it up and do some proper locking.

sure, feel free.

	Ingo

