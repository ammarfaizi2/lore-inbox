Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbTJETel (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbTJETel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:34:41 -0400
Received: from gaia.cela.pl ([213.134.162.11]:55563 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S263803AbTJETek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:34:40 -0400
Date: Sun, 5 Oct 2003 21:32:00 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: David Woodhouse <dwmw2@infradead.org>
cc: Andre Hedrick <andre@linux-ide.org>, Rob Landley <rob@landley.net>,
       "Henning P. Schmiedehausen" <hps@intermeta.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
In-Reply-To: <1065378470.3157.146.camel@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.44.0310052120440.12277-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You are so young and fresh to the game, it is cute.
> 
> http://www.gcom.com/home/support/whitepapers/linux-gnu-license.html

Can a module even be considered LGPL?  After all a module interfaces with
the kernel via including files from the kernel source - doesn't this
automatically mean that it is a derived work of at least a few of the
kernel headers (the module specific ones for example).  These headers
contribute code to the module as well: INC_MOD_USE_COUNT and the like...
And since the kernel is GPLed doesn't this mean that the entire module is
GPLed?

On the other hand any running program on linux dynamically links (via 
syscalls) against the kernel... I think everyone agrees that dynamically 
linking against the kernel in this manner should be allowed and not a 
violation of the GPL of the kernel source...


