Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbULBRRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbULBRRf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 12:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbULBRRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 12:17:35 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:16000
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261692AbULBRRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 12:17:33 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>, nickpiggin@yahoo.com.au
In-Reply-To: <20041202085518.58e0e8eb.akpm@osdl.org>
References: <20041201104820.1.patchmail@tglx>
	 <20041201211638.GB4530@dualathlon.random>
	 <1101938767.13353.62.camel@tglx.tec.linutronix.de>
	 <20041202033619.GA32635@dualathlon.random>
	 <1101985759.13353.102.camel@tglx.tec.linutronix.de>
	 <1101995280.13353.124.camel@tglx.tec.linutronix.de>
	 <20041202164725.GB32635@dualathlon.random>
	 <20041202085518.58e0e8eb.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 02 Dec 2004 18:17:31 +0100
Message-Id: <1102007851.13353.159.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-02 at 08:55 -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > I believe the thing you're hiding with the callback, is some screwup in
> >  the VM. It shouldn't fire oom 300 times in a row.
> 
> Well no ;)

:)

> Thomas, could you please put together a description of how to reproduce
> this behaviour?
> 

As I mentioned before. I'm using a PIII,500Mhz,128MB Machine. Kernel
compiled with PREEMPT=y.
I boot into runlevel 3 and start
# hackbench 40
from the shell.

Just adjust the number so hackbench eats up all the memory.

I have some more test cases with real applications, but they are not so
easy to reproduce. Hackbench resembles the forking server quite well.

tglx


