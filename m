Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVFWAN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVFWAN6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 20:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVFWALK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 20:11:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:59282 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261846AbVFWAKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 20:10:36 -0400
Date: Thu, 23 Jun 2005 02:10:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050623001023.GC11486@elte.hu>
References: <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com> <20050616173247.GA32552@elte.hu> <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org> <20050621131249.GB22691@elte.hu> <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org> <20050622082450.GA19957@elte.hu> <Pine.LNX.4.58.0506221434170.22191@echo.lysdexia.org> <20050622220007.GA28258@elte.hu> <Pine.LNX.4.58.0506221558260.22649@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506221558260.22649@echo.lysdexia.org>
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

> > these are all the first type of latencies, which seem to be hardware 
> > related. Could you try to boot the UP kernel, do you see these latencies 
> > there too? (if yes then please post those too)
> 
> On -50-11 UP, the ~200us idle is still showing up in the traces.  This 
> idle time, however, seems to be at random points within the trace.  
> Some of the traces attached are nearly identical except for where the 
> ~200us jump happens to fall.  Hardware induced latency?

yes, very likely hardware (or system BIOS, e.g. SMM) induced.

	Ingo
