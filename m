Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWJMTnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWJMTnV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 15:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWJMTnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 15:43:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19467 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750961AbWJMTnU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 15:43:20 -0400
Date: Fri, 13 Oct 2006 14:54:16 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Tuttle <thinkinginbinary+lkml@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dell Inspiron e1405 hangs on lid close in 64-bit mode
Message-ID: <20061013145415.GC5512@ucw.cz>
References: <e4cb19870610111010p3da2022bud047163417560033@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4cb19870610111010p3da2022bud047163417560033@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have a Dell Inspiron e1405 laptop with a Core 2 Duo 
> processor.
> Under every 64-bit kernel I have tried yet, it hangs 
> when I close the
> lid (or, I would assume, do anything else that activates 
> System
> Management Mode).  It works fine under 32-bit mode; 
> closing the lid
> turns the LCD off using DPMS.
> 
> I understand that this might be entirely outside the 
> control of the
> kernel developers, but I would of course love to be able 
> to use this
> laptop in 64-bit mode.  What information would be needed 
> to fix it,
> and/or how would I go about debugging it?  I've tried 
> turning the

Modify 64bit kernel entry point to do something trivial (flashing
character on vga text mode?) then see if lid close breaks it. If so,
blame smm, and force vendor to fix it.

-- 
Thanks for all the (sleeping) penguins.
