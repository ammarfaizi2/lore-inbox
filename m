Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270618AbTHETBr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 15:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270622AbTHETBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 15:01:47 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:65509 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S270618AbTHETBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 15:01:45 -0400
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: FINALLY caught a panic
References: <20030805122354.GL13456@rdlg.net>
	<Pine.LNX.4.53.0308050818130.7244@montezuma.mastecende.com>
	<20030805135046.GO13456@rdlg.net>
	<Pine.LNX.4.53.0308051003070.7244@montezuma.mastecende.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 05 Aug 2003 17:29:58 +0200
In-Reply-To: <Pine.LNX.4.53.0308051003070.7244@montezuma.mastecende.com>
Message-ID: <m3oez4t955.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> writes:

> > Code:  Bad EIP value.
> > 
> > >>EIP; 8011c560 Before first symbol   <=====
> > Trace; c011c47d <tasklet_hi_action+5d/90>
> > Trace; c011c1ff <do_softirq+6f/d0>
> > Trace; c0108bdb <do_IRQ+db/f0>
> > Trace; c0105400 <default_idle+0/40>
> > Trace; c0105400 <default_idle+0/40>
> > Trace; c010ae78 <call_do_IRQ+5/d>
> > Trace; c0105400 <default_idle+0/40>
> > Trace; c0105400 <default_idle+0/40>
> > Trace; c010542c <default_idle+2c/40>
> > Trace; c01054a2 <cpu_idle+42/60>
> > Trace; c0117e7f <release_console_sem+8f/a0>
> > Trace; c0117d8e <printk+11e/140>
> > 
> >  <0>Kernel panic: Aiee, killing interrupt handler!
> 
> It looks like someone freed a tasklet without removing it.

Not sure, note that EIP=0x80xxx and not 0xC0xxx.
-- 
Krzysztof Halasa
Network Administrator
