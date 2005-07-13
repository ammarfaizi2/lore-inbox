Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbVGMGf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVGMGf3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 02:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVGMGf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 02:35:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36271 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262511AbVGMGf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 02:35:26 -0400
Date: Wed, 13 Jul 2005 08:35:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: William Weston <weston@sysex.net>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050713063519.GB12661@elte.hu>
References: <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu> <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu> <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <1120269723.12256.11.camel@mindpipe> <Pine.LNX.4.58.0507040042220.31967@echo.lysdexia.org> <20050704111648.GA11073@elte.hu> <1121217531.26266.15.camel@mindpipe> <1121218088.4435.0.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121218088.4435.0.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> > I have found that heavy network traffic really kills the interactive
> > performance.  In the top excerpt below, gtk-gnutella is generating about
> > 320KB/sec of traffic.
> > 
> > These priorities do not look right:
> 
> Never mind, I just rediscovered the RT priority leakage bug.

ok. And is it fixed by recent kernels?

	Ingo
