Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVFVMdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVFVMdM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 08:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVFVMdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 08:33:12 -0400
Received: from imap.gmx.net ([213.165.64.20]:13986 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261166AbVFVMdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 08:33:08 -0400
X-Authenticated: #4399952
Date: Wed, 22 Jun 2005 14:32:47 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-V0.7.49-00
Message-ID: <20050622143247.07b78748@mango.fruits.de>
In-Reply-To: <Pine.OSF.4.05.10506220109490.17063-100000@da410.phys.au.dk>
References: <20050621084426.GA13094@elte.hu>
	<Pine.OSF.4.05.10506220109490.17063-100000@da410.phys.au.dk>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005 01:12:14 +0200 (METDST)
Esben Nielsen <simlo@phys.au.dk> wrote:

> On Tue, 21 Jun 2005, Ingo Molnar wrote:
> 
> > 
> > * Esben Nielsen <simlo@phys.au.dk> wrote:
> > 
> > > I am seeing very high latencies on 2.6.12-RT-V0.7.50-04 with a 
> > > modified realfeel2: maximum is 246 us. Shouldn't it be in the order of 
> > > 50 us?
> > 
> > i never got reliable results from realfeel - it should do the kind of 
> > careful things rtc_wakeup does to avoid false positives.
> > 
> I tried with rtc_wakeup while I was at work (which is on my disk at home) 
> - but it crashed my machine (one have to be _very_ carefull about what you
> do when you run in a task with RT priority!). I have fixed it now (see
> below patch) and it is running for the night. Let us see if I get similar
> results. 

Thanks for the patch. New version here:

http://affenbande.org/~tapas/rtc_wakeup/rtc_wakeup-0.0.2.tgz

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/
