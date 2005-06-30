Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbVF3Ueu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbVF3Ueu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbVF3UVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:21:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:60045 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263051AbVF3Txt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:53:49 -0400
Date: Thu, 30 Jun 2005 21:52:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-37
Message-ID: <20050630195258.GB20310@elte.hu>
References: <200506281927.43959.annabellesgarden@yahoo.de> <20050629193804.GA6256@elte.hu> <200506300136.01061.annabellesgarden@yahoo.de> <200506301952.22022.annabellesgarden@yahoo.de> <Pine.LNX.4.58.0506301238450.20655@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506301238450.20655@echo.lysdexia.org>
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

> Hi Ingo,
> 
> -50-37 wouldn't compile out of the box on my debug config.
> Here's a couple minor cleanups:

thanks, applied. except these:

> -	struct thread_info *ti = current_thread_info();
> +	//struct thread_info *ti = current_thread_info();

> -	struct thread_info *ti = current_thread_info();
> +	//struct thread_info *ti = current_thread_info();

they are needed in the nondebug build - i'll fix this up.

	Ingo
