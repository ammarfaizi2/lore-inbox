Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbVAVTnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbVAVTnA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 14:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVAVTnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 14:43:00 -0500
Received: from gprs214-39.eurotel.cz ([160.218.214.39]:46755 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262687AbVAVTm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 14:42:58 -0500
Date: Sat, 22 Jan 2005 20:42:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050122194242.GB21719@elf.ucw.cz>
References: <20050121100606.GB8042@dualathlon.random> <20050121120325.GA2934@elte.hu> <20050121093902.O469@build.pdx.osdl.net> <Pine.LNX.4.61.0501211338190.15744@chimarrao.boston.redhat.com> <20050121105001.A24171@build.pdx.osdl.net> <20050121195522.GA14982@elte.hu> <20050121203425.GB11112@dualathlon.random> <20050122103242.GC9357@elf.ucw.cz> <20050122172542.GF7587@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122172542.GF7587@dualathlon.random>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, seccomp is also getting very little testing, when ptrace gets a
> > lot of testing; I know that seccomp is simple, but I believe testing
> > coverage still make ptrace better choice.
> 
> It's not testing that makes code more secure. Testing verifys the code
> works in production, but testing almost never helps to find security
> issues, and often not even hidden subtle race conditions. Check how many
> security bugs have been found with testing.  Just go to bugtraq count
> them. I simply cannot relay on testing for the security part. I will
> relay on testing for everything else but not for this.

Well, then you can help auditing ptrace()... It is probably also true
that more people audited ptrace() than seccomp :-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
