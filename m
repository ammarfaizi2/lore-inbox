Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTLAAL7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 19:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTLAAL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 19:11:59 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:17281
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262038AbTLAAL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 19:11:57 -0500
Date: Sun, 30 Nov 2003 19:10:53 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops + crash in 2.6.0-test11
In-Reply-To: <20031130231948.21382.qmail@web40608.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0311301909390.31421@montezuma.fsmlabs.com>
References: <20031130231948.21382.qmail@web40608.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: 
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Dec 2003, [iso-8859-1] szonyi calin wrote:

> Hi
> I was watching tv with tvtime and reading lkml on yahoo mail
> (with opera
> if matters). I decided to start xawtv instead of tvtime because
> tvtime
> looked like it was skiping frames.
> So i pressed the q key in tvtime and with the tvtime window
> dissapeared
> also the xterm window from which it was started. I tryed to
> start xterm
> but the xterm window mapped quickly and then dissapeared. I
> switched to
> my syslog VT and noticed an oops. I couldn't start a new shell
> nor from
> console nor from X (starting a new shell gave me a segfault or
> an oops)
> I couldn't shutdown cleanly (i had to use sysrq)
>
> Attached are the program versions, config, dmesg (from syslog)
> and oopses.

How reproduceable is this? Can you try  with the following kernel config
options enabled? I'm suspecting the bttv driver.

CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SPINLOCK=y

Thanks

