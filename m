Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286272AbSAAObz>; Tue, 1 Jan 2002 09:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286275AbSAAObp>; Tue, 1 Jan 2002 09:31:45 -0500
Received: from adsl-212-59-30-243.takas.lt ([212.59.30.243]:61684 "EHLO
	gintaras.vetrunge.lt.eu.org") by vger.kernel.org with ESMTP
	id <S286272AbSAAObg>; Tue, 1 Jan 2002 09:31:36 -0500
Date: Tue, 1 Jan 2002 16:31:31 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: linux-kernel@vger.kernel.org,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
Message-ID: <20020101143131.GB1381@gintaras>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0112301618310.1011-100000@penguin.transmeta.com> <20020101054301.YWGP617.femail27.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020101054301.YWGP617.femail27.sdc1.sfba.home.com@there>
User-Agent: Mutt/1.3.24i
X-URL: http://ice.dammit.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2001 at 04:41:19PM -0500, Rob Landley wrote:
> X11 isn't always an improvement.  I've got an X hang on my laptop (about once 
> a week) that freezes the keyboard and ignores mouse clicks.  Numlock doesn't 
> change the keyboard LEDs, CTRL-ALT-BACKSPACE won't do a thing, and although I 
> can ssh in and run top (and see the CPU-eating loop), kill won't take X down 
> and kill-9 leaves the video display up so the console that thinks it's in 
> text mode, but isn't, is still useless.  (And that's assuming I'm plugged 
> into the network and have another box around to ssh in from...)

I sometimes get a similar problem on my desktop when switching between
text and X11 virtual consoles.  Keyboard + mouse die (PS/2 counter
becomes stuck according to /proc/interrupts).  ssh followed by chvt
helps.

Marius Gedminas
-- 
Of course I use Microsoft. Setting up a stable unix network is no challenge ;p
