Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267551AbSKQSpw>; Sun, 17 Nov 2002 13:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267552AbSKQSpw>; Sun, 17 Nov 2002 13:45:52 -0500
Received: from mx1.elte.hu ([157.181.1.137]:24494 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267551AbSKQSpv>;
	Sun, 17 Nov 2002 13:45:51 -0500
Date: Sun, 17 Nov 2002 21:09:08 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Dipankar Sarma <dipankar@gamebox.net>
Cc: Matthew Wilcox <willy@debian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Run timers as softirqs, not tasklets
In-Reply-To: <20021118001640.A27495@dikhow>
Message-ID: <Pine.LNX.4.44.0211172108160.12550-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Nov 2002, Dipankar Sarma wrote:

> I wrote that part of smptimers to run the per-CPU lists from per-CPU
> tasklets while porting Ingo's code to 2.5 and Ingo just included it. At
> that time, it didn't seem necessary to use up a softirq vector when it
> could be easily done using tasklets.

i think a separate timer softirq is justified, timers are important
enough.

	Ingo

