Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266575AbUBESOi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266598AbUBESOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:14:38 -0500
Received: from gprs146-93.eurotel.cz ([160.218.146.93]:37248 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266575AbUBESOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:14:36 -0500
Date: Thu, 5 Feb 2004 19:12:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>, dipankar@in.ibm.com
Subject: Re: New v. v. experimental HOTPLUG CPU megapatch.
Message-ID: <20040205181204.GA294@elf.ucw.cz>
References: <20040202154040.GA5895@elte.hu> <20040203074322.27A892C13E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203074322.27A892C13E@lists.samba.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is my first cut of a patch, still has some old code in it.  As an
> attachment since it's 70k (I'll split into multiple parts later, this
> is the x86 part, too).
> 
> Patch against 2.6.2-rc2-mm2.  Works basically, gives "APIC error on
> CPU1: 08(08)" under stress.  Clues welcome.
> 
> Basically consists of:
> 
> 1) New file stop_machine.[ch] which takes logic out of module.c (I
>    haven't converted module.c code over yet though).

I like this one. Something like this will be handy for SMP sleep
support.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
