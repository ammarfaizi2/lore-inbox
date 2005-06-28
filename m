Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVF1Ibw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVF1Ibw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVF1Ibd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:31:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36330 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261734AbVF1I3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 04:29:17 -0400
Date: Tue, 28 Jun 2005 10:28:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, William Weston <weston@sysex.net>,
       "K.R. Foley" <kr@cybsft.com>, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050628082836.GA19768@elte.hu>
References: <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org> <200506271329.14562.gene.heskett@verizon.net> <20050627195405.GB16804@elte.hu> <200506271717.28968.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506271717.28968.gene.heskett@verizon.net>
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


* Gene Heskett <gene.heskett@verizon.net> wrote:

> >I 
> > thought this might be some -RT-specific degradation.
> >
> > Ingo
> 
> As I just posted in another thread, with this boot I am now getting a 
> huge amount of almost strace like detail being output to VT1 from 
> kde's/kmails activities.  VT1 being the console I did the startx from.  
> Could this be related to commenting out that line in sched.c?

yeah, could be - could you try with it reverted again?

> Getting all that detail being output to VT1, is there any way I can 
> enlarge the VT's scrollback memory buffer?  It's only about 2kb, maybe 
> less, less than 2 full screens full.  I'm used to haveing about a 10 
> meg scrollback buffer available for traceing purposes in an x console.  
> I'd appreciate the same length of scrollback for the VT's.

no idea. In gnome-terminal if you edit the current profile there's a 
scrollback item with # of lines of scrollback you can save.

	Ingo
