Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbTESQxH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 12:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTESQxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 12:53:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:17123 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id S262270AbTESQxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 12:53:06 -0400
Date: Mon, 19 May 2003 19:02:38 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Werner Almesberger <wa@almesberger.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-cleanup-2.5.69-A0
In-Reply-To: <20030519135144.A1432@almesberger.net>
Message-ID: <Pine.LNX.4.44.0305191900400.14615-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 May 2003, Werner Almesberger wrote:

> I could make it yield if anything else is runnable (I already check for
> this, but just to panic). I suppose if I just set p->static_prio to
> MAX_PRIO-1, this thread that would give me only very few activations
> while other processes are runnable ?

so you really want to run every time there's idle time, but you also want
to sleep until the event that causes some other thread to run, right?

	Ingo

