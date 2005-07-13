Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVGMRXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVGMRXk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVGMRVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:21:15 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:14259 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261590AbVGMRUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:20:15 -0400
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: William Weston <weston@sysex.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050713063519.GB12661@elte.hu>
References: <200506301952.22022.annabellesgarden@yahoo.de>
	 <20050630205029.GB1824@elte.hu>
	 <200507010027.33079.annabellesgarden@yahoo.de>
	 <20050701071850.GA18926@elte.hu>
	 <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org>
	 <1120269723.12256.11.camel@mindpipe>
	 <Pine.LNX.4.58.0507040042220.31967@echo.lysdexia.org>
	 <20050704111648.GA11073@elte.hu> <1121217531.26266.15.camel@mindpipe>
	 <1121218088.4435.0.camel@mindpipe>  <20050713063519.GB12661@elte.hu>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 13:20:12 -0400
Message-Id: <1121275213.4435.39.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 08:35 +0200, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > I have found that heavy network traffic really kills the interactive
> > > performance.  In the top excerpt below, gtk-gnutella is generating about
> > > 320KB/sec of traffic.
> > > 
> > > These priorities do not look right:
> > 
> > Never mind, I just rediscovered the RT priority leakage bug.
> 
> ok. And is it fixed by recent kernels?
> 

Yes, I have not seen the problem yet with V0.7.51-28.

Lee

