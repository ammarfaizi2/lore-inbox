Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSIIBtt>; Sun, 8 Sep 2002 21:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSIIBtt>; Sun, 8 Sep 2002 21:49:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23713 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316070AbSIIBtt>;
	Sun, 8 Sep 2002 21:49:49 -0400
Date: Mon, 9 Sep 2002 03:57:55 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Anton Altaparmakov <aia21@cantab.net>, <linux-kernel@vger.kernel.org>
Subject: Re: pinpointed: PANIC caused by dequeue_signal() in current Linus 
 BK tree
In-Reply-To: <Pine.LNX.4.44.0209081835260.1401-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209090357180.6125-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


indeed the problem is that the shared_pending queue is not initialized in
INIT_SIGNALS. Patch in a few minutes.

	Ingo

