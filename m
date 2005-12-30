Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVL3ASl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVL3ASl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 19:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVL3ASl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 19:18:41 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:64957 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751163AbVL3ASl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 19:18:41 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: gcoady@gmail.com
Cc: Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@redhat.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <u8u8r1ttmtubpvd87sf9mq4fi2of0l6js4@4ax.com>
References: <1135726300.22744.25.camel@mindpipe>
	 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
	 <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu>
	 <20051229100233.GA12056@redhat.com> <20051229101736.GA2560@elte.hu>
	 <1135887072.6804.9.camel@mindpipe> <1135887966.6804.11.camel@mindpipe>
	 <20051229202848.GC29546@elte.hu>
	 <u8u8r1ttmtubpvd87sf9mq4fi2of0l6js4@4ax.com>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 19:18:38 -0500
Message-Id: <1135901918.4568.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 11:08 +1100, Grant Coady wrote:
> On Thu, 29 Dec 2005 21:28:48 +0100, Ingo Molnar <mingo@elte.hu> wrote:
> 
> >
> >thanks, applied - new version uploaded.
> 
> I just booted with latency tracer, it died with (copy by hand):
> {   40} [<c012e74a>] debug_stackoverflow+0x6a/0xc0
> 
> Much unusual stuff (several screenfuls) scrolled up prior to lockup.

Can you verify that it works with CONFIG_DEBUG_STACKOVERFLOW disabled?

Lee

