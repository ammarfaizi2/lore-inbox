Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318806AbSH1M4w>; Wed, 28 Aug 2002 08:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318812AbSH1M4v>; Wed, 28 Aug 2002 08:56:51 -0400
Received: from kim.it.uu.se ([130.238.12.178]:34209 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S318806AbSH1M4v>;
	Wed, 28 Aug 2002 08:56:51 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15724.51593.23255.339865@kim.it.uu.se>
Date: Wed, 28 Aug 2002 15:00:56 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.32 doesn't beep?
In-Reply-To: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds 2.5.32 announcement:
 > ... The input layer switch-over may also end up being a bit painful
 > for a while, since that not only adds a lot of config options that you
 > have to get right to have a working keyboard and mouse (we'll fix that
 > usability nightmare), but the drivers themselves are different and there
 > are likely devices out there that depended on various quirks.

I've noticed that in 2.5.32 with CONFIG_KEYBOARD_ATKBD=y, the kernel no
longer beeps via the PC speaker. Both (at the console) hitting DEL or BS
at the start of input or doing a simple echo ^G are now silent.

Call me old-fashioned, but I want those beeps back :-)

/Mikael
