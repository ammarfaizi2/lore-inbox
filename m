Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbVI1Jro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVI1Jro (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 05:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbVI1Jro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 05:47:44 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:34742 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750768AbVI1Jro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 05:47:44 -0400
Date: Wed, 28 Sep 2005 11:48:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: dwalker@mvista.com, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, emann@mrv.com,
       yang.yi@bmrtech.com
Subject: Re: 2.6.14-rc2-rt2
Message-ID: <20050928094805.GA30446@elte.hu>
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu> <1127840377.27319.11.camel@cmn3.stanford.edu> <1127862619.4004.48.camel@dhcp153.mvista.com> <1127876673.9430.2.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127876673.9430.2.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> > Here's the fix.
> 
> Hey thanks! That fixes that, but the compile fails further along:
> 
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
> arch/i386/kernel/built-in.o(.text+0xf086): In function `do_powersaver':
> longhaul.c: undefined reference to `safe_halt'
> arch/i386/kernel/built-in.o(.text+0xf271): In function
> `longhaul_setstate':
> longhaul.c: undefined reference to `safe_halt'
> make: *** [.tmp_vmlinux1] Error 1

could you try 2.6.14-rc2-rt6, does it build?

	Ingo
