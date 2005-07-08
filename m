Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVGHIEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVGHIEZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 04:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVGHIEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 04:04:25 -0400
Received: from mx2.elte.hu ([157.181.151.9]:30939 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261916AbVGHIEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 04:04:22 -0400
Date: Fri, 8 Jul 2005 10:03:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-12
Message-ID: <20050708080359.GA32001@elte.hu>
References: <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu> <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu> <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu> <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507061802570.20214@echo.lysdexia.org> <20050707104859.GD22422@elte.hu> <Pine.LNX.4.58.0507071257320.25321@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507071257320.25321@echo.lysdexia.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Weston <weston@sysex.net> wrote:

> -51-12 is still exhibhiting the RT priority leakage, but isn't 
> producing any BUG messages.

could you check whether the priority leakage happens if you disable SMP?  
(if you can reproduce it easily)

	Ingo
