Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268514AbSIRRzV>; Wed, 18 Sep 2002 13:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268515AbSIRRzU>; Wed, 18 Sep 2002 13:55:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43422 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S268514AbSIRRzF>;
	Wed, 18 Sep 2002 13:55:05 -0400
Date: Wed, 18 Sep 2002 20:07:21 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andries Brouwer <aebr@win.tue.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <20020918175055.GX3530@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0209182006380.25598-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, William Lee Irwin III wrote:

> Not quite all of them. top(1) takes out the machine by triggering calls
> to get_pid_list(), which NMI oopses fork() and exit() on other cpus.

one of my patches in 2.5.35 solves that.

	Ingo

