Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268051AbUIVWhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268051AbUIVWhN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 18:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268060AbUIVWhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 18:37:13 -0400
Received: from gprs214-200.eurotel.cz ([160.218.214.200]:49289 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268051AbUIVWhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 18:37:11 -0400
Date: Thu, 23 Sep 2004 00:34:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: year 2038 problem on x86-64
Message-ID: <20040922223420.GE17997@elf.ucw.cz>
References: <2Hn0k-2wz-9@gated-at.bofh.it> <2HnjK-2Ha-3@gated-at.bofh.it> <m33c1a9byb.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33c1a9byb.fsf@averell.firstfloor.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >
> > ... __ARCH_WANT_SYS_TIME actually is set on x86-64.
> 
> But it's not used. It declares an own sys_time64 in arch/x86_64
> By default the vsyscall code is used.

So should __ARCH_WANT_SYS_TIME be  killed from x86_64?

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
