Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUINXzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUINXzy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 19:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266352AbUINXzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 19:55:54 -0400
Received: from [217.132.60.104] ([217.132.60.104]:27778 "EHLO localhost")
	by vger.kernel.org with ESMTP id S266463AbUINXzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 19:55:39 -0400
Date: Wed, 15 Sep 2004 03:58:20 +0300
From: Sasha Khapyorsky <sashak@smlink.com>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97    
 patch)
Message-ID: <20040915035820.1cdccaa5@localhost>
In-Reply-To: <MPG.1bb164a85e6c9d459896e9@news.gmane.org>
References: <200409111850.i8BIowaq013662@harpo.it.uu.se>
	<20040912011128.031f804a@localhost>
	<Pine.LNX.4.60.0409131526050.29875@tomservo.workpc.tds.net>
	<20040914175949.6b59a032@sashak.lan>
	<MPG.1bb164a85e6c9d459896e9@news.gmane.org>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 23:04:41 +0200
Giuseppe Bilotta <bilotta78@hotpop.com> wrote:

> Sasha Khapyorsky wrote:
> > Such modems also exist (AC97 controller + MC97 codec + DAA), but
> > less popular (especially with laptops there modem are mostly used).
> 
> I have one such built in in my Dell Inspiron 8200, which is why 
> I'm following this thread with particular interest.
> 
> The strange thing is that under Windows the modem is configured 
> as a Conexant thingie ... or is the problem that I have both 
> and the Conexant thingie is the one connected to the actual 
> modem plug? Is there a way to know this (other than having a 
> look inside my laptop, that is)?

If it looks like this:

00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller

it is most likely on-board south bridge and MDC (or other riser)
modem. This may work with ALSA.

Or send me your lspci.

Sasha.

