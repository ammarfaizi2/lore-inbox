Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268346AbTBNKqE>; Fri, 14 Feb 2003 05:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268349AbTBNKqE>; Fri, 14 Feb 2003 05:46:04 -0500
Received: from denise.shiny.it ([194.20.232.1]:9941 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S268346AbTBNKqD>;
	Fri, 14 Feb 2003 05:46:03 -0500
Message-ID: <XFMail.20030214115507.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com>
Date: Fri, 14 Feb 2003 11:55:07 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: RE: Synchronous signal delivery..
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It's a generic "synchronous signal delivery" method, and it uses a
> perfectly regular file descriptor to deliver an arbitrary set of signals
> that are pending.
>
> It adds one new system call:
>
>       fd = sigfd(sigset_t * mask, unsigned long flags);

IMHO it's not simply a signal delivery system, it's a message queue. It's
possible to deliver any kind of data to the process, and the fd can be
used to send data to other processes as well.


Bye.

