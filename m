Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbULBTR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbULBTR7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 14:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbULBTR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 14:17:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:20941 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261729AbULBTRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 14:17:54 -0500
Date: Thu, 2 Dec 2004 11:22:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: andrea@suse.de, marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-Id: <20041202112208.34150647.akpm@osdl.org>
In-Reply-To: <1102014493.13353.239.camel@tglx.tec.linutronix.de>
References: <20041201104820.1.patchmail@tglx>
	<20041201211638.GB4530@dualathlon.random>
	<1101938767.13353.62.camel@tglx.tec.linutronix.de>
	<20041202033619.GA32635@dualathlon.random>
	<1101985759.13353.102.camel@tglx.tec.linutronix.de>
	<1101995280.13353.124.camel@tglx.tec.linutronix.de>
	<20041202164725.GB32635@dualathlon.random>
	<20041202085518.58e0e8eb.akpm@osdl.org>
	<20041202180823.GD32635@dualathlon.random>
	<1102013716.13353.226.camel@tglx.tec.linutronix.de>
	<20041202110729.57deaf02.akpm@osdl.org>
	<1102014493.13353.239.camel@tglx.tec.linutronix.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, 2004-12-02 at 11:07 -0800, Andrew Morton wrote:
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > FYI, I tried with 2.6 UP and PREEMPT=n. The result is more horrible. The
> > > box just gets stuck in an endless swap in/swap out and does not respond
> > > to anything else than SysRq-T and the reset button.
> > 
> > There's a patch in -mm which causes the oom-killer to be invoked each time
> > you hit sysrq-F, which sounds like a fine idea to me.
> 
> Can you please explain, how I can hit sysrq-F when I can't log into the
> remote machine ?
> 

umm, in the same way you're using "SysRq-T and the reset button"?

You can issue sysrq commands over serial consoles too.
