Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbUC1WZT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 17:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUC1WZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 17:25:19 -0500
Received: from gprs214-54.eurotel.cz ([160.218.214.54]:61825 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262416AbUC1WZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 17:25:15 -0500
Date: Mon, 29 Mar 2004 00:25:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Arthur Othieno <a.othieno@bluewin.ch>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl,
       kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: Kill IDE debug messages during suspend
Message-ID: <20040328222502.GJ406@elf.ucw.cz>
References: <20040326001154.GA3353@elf.ucw.cz> <20040328205822.GA846@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328205822.GA846@mars>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> What about these stale #ifdefs?
> 
> drivers/ide/ide-io.c:126:#ifdef DEBUG_PM
> drivers/ide/ide-io.c:220:#ifdef DEBUG_PM
> drivers/ide/ide-io.c:638:#ifdef DEBUG_PM
> drivers/ide/ide-io.c:662:#ifdef DEBUG_PM

I wanted to leave debugging possible...

> This patch sweeps up both DEBUG_PM and DEBUG #ifdefs in favour of pr_debug()

...but your patch looks better.
								Pavel

>  ide-io.c |   74 ++++++++++++++++++++++++++-------------------------------------

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
