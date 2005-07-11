Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVGKSyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVGKSyO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVGKSwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 14:52:18 -0400
Received: from unused.mind.net ([69.9.134.98]:36773 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S261494AbVGKStp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 14:49:45 -0400
Date: Mon, 11 Jul 2005 11:49:02 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-12
In-Reply-To: <1121011953.14580.0.camel@twins>
Message-ID: <Pine.LNX.4.58.0507111141060.13011@echo.lysdexia.org>
References: <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> 
 <20050703140432.GA19074@elte.hu> <20050703181229.GA32741@elte.hu> 
 <Pine.LNX.4.58.0507061802570.20214@echo.lysdexia.org>  <20050707104859.GD22422@elte.hu>
  <Pine.LNX.4.58.0507071257320.25321@echo.lysdexia.org>  <20050708080359.GA32001@elte.hu>
  <Pine.LNX.4.58.0507081246340.30549@echo.lysdexia.org>  <1120944243.12169.3.camel@twins>
 <1120994288.14680.0.camel@twins>  <20050710151008.GA28194@elte.hu> 
 <1121010236.14680.6.camel@twins> <1121011953.14580.0.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jul 2005, Peter Zijlstra wrote:

> On Sun, 2005-07-10 at 17:43 +0200, Peter Zijlstra wrote:
> 
> > > I've also 
> > > released the -51-23 patch with these changes included. Does this fix 
> > > priority leakage on your SMP system?
> > > 
> > 
> > -51-24 right? I'll give it a spin.
> > 
> 
> a quick test seems to indicate it is indeed solved.

Running -51-26.  Priority leakage on the SMT box is gone.  This indeed 
fixes the scheduler meltdown issue I was dealing with.  Great work, guys!

--ww
