Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318815AbSH1NIN>; Wed, 28 Aug 2002 09:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318818AbSH1NIN>; Wed, 28 Aug 2002 09:08:13 -0400
Received: from kim.it.uu.se ([130.238.12.178]:34977 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S318815AbSH1NIM>;
	Wed, 28 Aug 2002 09:08:12 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15724.52284.521246.505806@kim.it.uu.se>
Date: Wed, 28 Aug 2002 15:12:28 +0200
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.32 doesn't beep?
In-Reply-To: <20020828150522.A13090@ucw.cz>
References: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com>
	<15724.51593.23255.339865@kim.it.uu.se>
	<20020828150522.A13090@ucw.cz>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik writes:
 > On Wed, Aug 28, 2002 at 03:00:56PM +0200, Mikael Pettersson wrote:
 > 
 > > Linus Torvalds 2.5.32 announcement:
 > >  > ... The input layer switch-over may also end up being a bit painful
 > >  > for a while, since that not only adds a lot of config options that you
 > >  > have to get right to have a working keyboard and mouse (we'll fix that
 > >  > usability nightmare), but the drivers themselves are different and there
 > >  > are likely devices out there that depended on various quirks.
 > > 
 > > I've noticed that in 2.5.32 with CONFIG_KEYBOARD_ATKBD=y, the kernel no
 > > longer beeps via the PC speaker. Both (at the console) hitting DEL or BS
 > > at the start of input or doing a simple echo ^G are now silent.
 > > 
 > > Call me old-fashioned, but I want those beeps back :-)
 > 
 > 2.5.32 still has quite complex input core config options - sorry, my
 > fault, and I'll fix it soon. You have to enable CONFIG_INPUT_MISC and
 > CONFIG_INPUT_PCSPKR.

Thanks. I'll test that later today.

/Mikael
