Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVAWAIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVAWAIT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 19:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVAWAIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 19:08:18 -0500
Received: from gprs214-39.eurotel.cz ([160.218.214.39]:10909 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261163AbVAWAIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 19:08:17 -0500
Date: Sun, 23 Jan 2005 01:07:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050123000703.GC21719@elf.ucw.cz>
References: <20050121120325.GA2934@elte.hu> <20050121093902.O469@build.pdx.osdl.net> <Pine.LNX.4.61.0501211338190.15744@chimarrao.boston.redhat.com> <20050121105001.A24171@build.pdx.osdl.net> <20050121195522.GA14982@elte.hu> <20050121203425.GB11112@dualathlon.random> <20050122103242.GC9357@elf.ucw.cz> <20050122172542.GF7587@dualathlon.random> <20050122194242.GB21719@elf.ucw.cz> <20050122233418.GH7587@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122233418.GH7587@dualathlon.random>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, then you can help auditing ptrace()... It is probably also true
> > that more people audited ptrace() than seccomp :-).
> 
> Why should I spend time auditing ptrace when I have a superior solution
> that doesn't require me any auditing at all? I've an huge pile of
> work,

Adding code is easy, but in the long term would lead to maintainance
nightmare. Adding seccomp code that does subset of ptrace, just
because ptrace audit is lot of work, seems like a wrong thing to
do. Sorry.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
