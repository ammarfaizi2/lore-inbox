Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVBURP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVBURP6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 12:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVBURP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 12:15:58 -0500
Received: from fire.osdl.org ([65.172.181.4]:31667 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262041AbVBURPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 12:15:54 -0500
Date: Mon, 21 Feb 2005 09:15:45 -0800
From: cliff white <cliffw@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-ac12 + kernbench == oom-killer: (OSDL)
Message-ID: <20050221091545.2b11cdfc@es175>
In-Reply-To: <1108757251.17213.38.camel@localhost.localdomain>
References: <20050208145707.1ebbd468@es175>
	<20050209013617.GC2686@pclin040.win.tue.nl>
	<E1D2BPv-0006T3-Q6@es175>
	<1108757251.17213.38.camel@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed-Claws 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2005 20:07:33 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Gwe, 2005-02-18 at 16:55, Cliff White wrote:
> > Okay, with just vm.overcommit=2, things are still bad:
> > http://khack.osdl.org/stp/300854/logs/TestRunFailed.console.log.txt
> > 
> > Suggestion for vm.overcommit_ratio ?
> > Or should i repeat with later -ac ?
> 
> Thats showing up problems in the core code still. The OOM in this case
> is because the kernel is deciding it is out of memory when it's merely
> constipated with dirty pages for disk write by the look of it.

Okay, same question - is there a tweak or a patch I can try here?
cliffw

> 
> Alan
> 


-- 
"Ive always gone through periods where I bolt upright at four in the morning; 
now at least theres a reason." -Michael Feldman
