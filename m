Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283828AbRLEIsh>; Wed, 5 Dec 2001 03:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283827AbRLEIs1>; Wed, 5 Dec 2001 03:48:27 -0500
Received: from denise.shiny.it ([194.20.232.1]:184 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S283828AbRLEIsP>;
	Wed, 5 Dec 2001 03:48:15 -0500
Message-ID: <XFMail.20011205094744.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3C0BDC33.6E18C815@colorfullife.com>
Date: Wed, 05 Dec 2001 09:47:44 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: RE: [PATCH] improve spinlock debugging
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Tested on i386/UP, but it should work on all platforms. It contains
> runtime checks for:
>
> - missing initialization
> - recursive lock
> - double unlock
> - incorrect use of spin_is_locked() or spin_trylock() [both function
> do not work as expected on uniprocessor builds]
> The next step are checks for spinlock ordering mismatches.
>
> Which other runtime checks are possible?

It's very useful to log when a lock(irq) is held more than xx ms
and who is the caller. Is it possible ?


Bye.

