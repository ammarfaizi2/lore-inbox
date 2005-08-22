Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbVHVW2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbVHVW2K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbVHVWZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:25:28 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:17289 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751413AbVHVWZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:25:07 -0400
Date: Mon, 22 Aug 2005 10:44:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: 2.6.13-rc6-rt9: compile errors
Message-ID: <20050822084453.GA22650@elte.hu>
References: <20050818060126.GA13152@elte.hu> <20050818225429.GI3822@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050818225429.GI3822@stusta.de>
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


* Adrian Bunk <bunk@stusta.de> wrote:

> I'm getting the following compile errors:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `pi_init':
> : multiple definition of `pi_init'
> kernel/built-in.o:(.bss+0x80f0): first defined here

> Note: pi_init is a global function in drivers/block/paride/paride.c .

thanks - fixed it in my tree.

	Ingo
