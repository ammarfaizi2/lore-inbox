Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVGDLUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVGDLUP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 07:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVGDLUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 07:20:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:12742 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261643AbVGDLQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 07:16:54 -0400
Date: Mon, 4 Jul 2005 13:16:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050704111648.GA11073@elte.hu>
References: <200506281927.43959.annabellesgarden@yahoo.de> <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu> <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu> <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <1120269723.12256.11.camel@mindpipe> <Pine.LNX.4.58.0507040042220.31967@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507040042220.31967@echo.lysdexia.org>
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

> > Which video driver is X using?  What nice value is the X server running
> > at?
> 
> Hardware is Intel 82865G (integrated) with DRM i915 1.1.0 20040405 and 
> xorg-3.8.2 i810 driver, running at nice 0, priority 15.  Should I bump 
> the priority up?  To realtime?

i'd first suggest to try the latest kernel, before changing your X 
config - i think the bug might have been fixed meanwhile.

	Ingo
