Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSGUVY4>; Sun, 21 Jul 2002 17:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSGUVY4>; Sun, 21 Jul 2002 17:24:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37822 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S314080AbSGUVYz>;
	Sun, 21 Jul 2002 17:24:55 -0400
Date: Sun, 21 Jul 2002 23:26:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: [patch] "big IRQ lock" removal, 2.5.27-A9
In-Reply-To: <Pine.LNX.4.44.0207212255130.27964-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207212324330.28931-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the genhd.c bit is safe as well, removed the comment. Only the tty and the
ide/main.c changes are left the 'dubious' category - everything else is
supposed to be safe. (and of course there's all the other stuff that does
not compile at the moment.) Latest patch is at:
 
    http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-A9

	Ingo

