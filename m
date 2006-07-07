Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWGGVsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWGGVsE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWGGVsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:48:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26373 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751261AbWGGVsC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:48:02 -0400
Date: Fri, 7 Jul 2006 21:47:37 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.18-rc1 broke resume from APM suspend on Latitude CPi
Message-ID: <20060707214736.GE5393@ucw.cz>
References: <200607071901.k67J1Q5s023842@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607071901.k67J1Q5s023842@harpo.it.uu.se>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Kernel 2.6.18-rc1 broke resume from APM suspend (to RAM)
> on my old Dell Latitude CPi laptop. At resume the disk
> spins up and the screen gets lit, but there is no response
> to the keyboard, not even sysrq. All other system activity
> also appears to be halted.
> 
> I did the obvious test of reverting apm.c to the 2.6.17
> version and fixing up the fallout from the TIF_POLLING_NRFLAG
> changes, but it made no difference. So the problem must be
> somewhere else.

driver model changes?

Can you retry with minimum drivers loaded, init=/bin/bash?

-- 
Thanks for all the (sleeping) penguins.
