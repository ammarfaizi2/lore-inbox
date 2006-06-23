Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWFWMpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWFWMpe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 08:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWFWMpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 08:45:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17561 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932565AbWFWMpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 08:45:34 -0400
Date: Fri, 23 Jun 2006 14:44:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: stephen@blacksapphire.com, benm@symmetric.co.nz,
       kernel list <linux-kernel@vger.kernel.org>, radek.stangel@gmsil.com
Subject: Re: IPWireless 3G PCMCIA Network Driver and GPL
Message-ID: <20060623124405.GA8027@elf.ucw.cz>
References: <20060616094516.GA3432@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060616094516.GA3432@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm trying to get "IPWireless 3G PCMCIA" to work under linux. There
> are two problems:
> 
> * first, only available version is for 2.6.12, and fixes to make it
> compile under 2.6.16 don't seem to be trivial
> 
> What is worse,
> 
> /*
>  * IPWireless 3G PCMCIA Network Driver
>  *
>  *   by Stephen Blackheath <stephen@blacksapphire.com>,
>  *      Ben Martel <benm@symmetric.co.nz>
>  *
>  * Copyrighted as follows:
>  *   Copyright (C) 2004 by Symmetric Systems Ltd (NZ)
>  */
> 
> ...so I'm not even allowed to fix it. I believe that driver should be
> GPLed -- it is unusable without pcmcia packages after all.

Uhuh, I was blind, there's MODULE_LICENSE("GPL") there, so all should
be fine. So... there are no legal problems and it is all "simple
matter of programming". Now... if someone lent me the PCMCIA/SIM
combination for a month, I guess I should be able to get it going in
2.6.16, and I should be able to get it into shape for mainline, too...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
