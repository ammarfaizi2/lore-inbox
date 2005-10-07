Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVJGLsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVJGLsL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 07:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVJGLsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 07:48:11 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58791 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932368AbVJGLsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 07:48:10 -0400
Date: Fri, 7 Oct 2005 13:48:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt10 - xruns & config questions
Message-ID: <20051007114848.GE857@elte.hu>
References: <5bdc1c8b0510061152o686c5774x2d0514a1f1b4e463@mail.gmail.com> <20051006195242.GA15448@elte.hu> <5bdc1c8b0510061307saf22655y26dd1e608b33a40c@mail.gmail.com> <5bdc1c8b0510061338r41e0b51ds2efd435a591d953e@mail.gmail.com> <5bdc1c8b0510061907w372cb406x45140b01e4011c4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0510061907w372cb406x45140b01e4011c4a@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Knecht <markknecht@gmail.com> wrote:

> However, at odd times I still get xruns. For instance one set of xruns 
> came while browsing the web. I was on this page:

> and got 2 xruns:
> 
> 18:20:06.541 XRUN callback (8).
> **** alsa_pcm: xrun of at least 3.172 msecs
> **** alsa_pcm: xrun of at least 0.967 msecs
> 18:20:07.908 XRUN callback (1 skipped).
> 
> So, while things are far, far better for me than they were earlier 
> this week, there are still some problems I'd like to get to the bottom 
> of if possible.

one thing i noticed: you have CONFIG_SMP set. Is it a true SMP x64 
system? In any case, could you try without CONFIG_SMP, just to test 
whether the latencies are related to SMP.

	Ingo
