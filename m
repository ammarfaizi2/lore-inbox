Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287657AbRLaVn4>; Mon, 31 Dec 2001 16:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287654AbRLaVnq>; Mon, 31 Dec 2001 16:43:46 -0500
Received: from alteon01f.roc.frontiernet.net ([66.133.130.236]:23063 "HELO
	relay01.roc.frontiernet.net") by vger.kernel.org with SMTP
	id <S287657AbRLaVnl>; Mon, 31 Dec 2001 16:43:41 -0500
Date: Mon, 31 Dec 2001 16:42:58 -0500
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
Message-ID: <20011231164258.A1099@vaxerdec.homeip.net>
Mail-Followup-To: Scott McDermott <vaxerdec>, linux-kernel@vger.kernel.org
In-Reply-To: <200112302117.fBULHISr011887@svr3.applink.net> <Pine.LNX.4.33.0112301618310.1011-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112301618310.1011-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 30, 2001 at 04:19:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds on Sun 30/12 16:19 -0800:
> No sane person should use frame buffers if they have the choice.

Text mode is slow and has poor resolution, yes even svga text mode stuff
is way slower than accelerated fbconsole for me, I don't like having to
wait for the screen to update when I page a file and go to the next
page.

And why require me to load X just to have a usuable system? Yes I think
when I have to switch consoles so a program doing a lot of screen output
doesn't block endlessly on my slow textmode display is unusable.
