Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273703AbRIWX6e>; Sun, 23 Sep 2001 19:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273702AbRIWX6O>; Sun, 23 Sep 2001 19:58:14 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35589 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273701AbRIWX6K>; Sun, 23 Sep 2001 19:58:10 -0400
Subject: Re: [PATCH] tty canonical mode: nicer erase behaviour
To: zefram@fysh.org
Date: Mon, 24 Sep 2001 01:03:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <E15lHUG-0001N5-00@bowl.fysh.org> from "zefram@fysh.org" at Sep 23, 2001 11:12:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15lJDP-0000qe-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> proposed change would have broken the line editor for many of us.
> As it is, ZLE just works, with no extra effort, on any text terminal,
> and we get no complaints.

And bash treats the two delete keys differently - something a similarly
religious group believe to be the right thing to do

> pipes to talk to the user's actual terminal.  We can't change that,
> and the result is that Unix systems have to handle whatever terminal
> type the user is using.

Which is why they have termcap, terminfo, and x keyboard maps. The kernel
is not there to cover up for usermode programmers inability to get
things right. It has enough to do covering up for the hardware folk

Alan
