Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbSIZPYs>; Thu, 26 Sep 2002 11:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261386AbSIZPYs>; Thu, 26 Sep 2002 11:24:48 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:18442 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S261385AbSIZPYr>;
	Thu, 26 Sep 2002 11:24:47 -0400
Subject: Re: Mouse/Keyboard problems with 2.5.38
From: Stian Jordet <liste@jordet.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020926133725.A8851@ucw.cz>
References: <1032996672.11642.6.camel@chevrolet>
	<20020926105853.A168142@ucw.cz> <1033039991.708.6.camel@chevrolet> 
	<20020926133725.A8851@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Sep 2002 17:30:09 +0200
Message-Id: <1033054211.587.6.camel@chevrolet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 2002-09-26 kl. 13:37 skrev Vojtech Pavlik:
> Hmm, have you looked into 'dmesg'? It prints the information with
> KERN_DEBUG priority, which often won't make it on the screen or into the
> logs ...
> 
> > I did, however, find out that if I press SHIFT+what
> > ever of the buttons arrows, insert, home, page up/down, delete and end,
> > I get just the same behaviour. It does not happen with CTRL or ALT.
> 
> Can you try passing 'i8042_direct' on the kernel command line to see if
> it cures the problem? It looks like your keyboard is doing some very
> strange 84-key-at-emulation, stranger than others do ...
> 
You had, ofcourse right, it was in my syslog. But the keystroke that
make my computer freeze isn't there. This is the last line:

kernel: atkbd.c: Received 1d flags 00

But I find this line several places, so it's obviously not the one
causing the crash. Altough, when passing i8042_direct to the kernel,
everything works just as expected. My keyboard is a Logitech Cordless
Desktop. The keyboard and mouse shares the same receiver, which both is
connected via ps/2. 

Best regards,
Stian Jordet

