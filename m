Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbULBR2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbULBR2V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 12:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbULBR2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 12:28:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:29919 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261696AbULBR2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 12:28:18 -0500
Date: Thu, 2 Dec 2004 09:27:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: andrea@suse.de, marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-Id: <20041202092744.0acb38b6.akpm@osdl.org>
In-Reply-To: <1102007851.13353.159.camel@tglx.tec.linutronix.de>
References: <20041201104820.1.patchmail@tglx>
	<20041201211638.GB4530@dualathlon.random>
	<1101938767.13353.62.camel@tglx.tec.linutronix.de>
	<20041202033619.GA32635@dualathlon.random>
	<1101985759.13353.102.camel@tglx.tec.linutronix.de>
	<1101995280.13353.124.camel@tglx.tec.linutronix.de>
	<20041202164725.GB32635@dualathlon.random>
	<20041202085518.58e0e8eb.akpm@osdl.org>
	<1102007851.13353.159.camel@tglx.tec.linutronix.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
>
> > Thomas, could you please put together a description of how to reproduce
>  > this behaviour?
>  > 
> 
>  As I mentioned before. I'm using a PIII,500Mhz,128MB Machine. Kernel
>  compiled with PREEMPT=y.
>  I boot into runlevel 3 and start
>  # hackbench 40
>  from the shell.
> 
>  Just adjust the number so hackbench eats up all the memory.

How much swap space is online?
