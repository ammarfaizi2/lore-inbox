Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbULCWWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbULCWWF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 17:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbULCWWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 17:22:04 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:14480 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262416AbULCWWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 17:22:01 -0500
Date: Fri, 3 Dec 2004 23:21:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041203222145.GQ32635@dualathlon.random>
References: <1101938767.13353.62.camel@tglx.tec.linutronix.de> <20041202033619.GA32635@dualathlon.random> <1101985759.13353.102.camel@tglx.tec.linutronix.de> <1101995280.13353.124.camel@tglx.tec.linutronix.de> <20041202164725.GB32635@dualathlon.random> <20041202085518.58e0e8eb.akpm@osdl.org> <20041202180823.GD32635@dualathlon.random> <1102013716.13353.226.camel@tglx.tec.linutronix.de> <20041202233459.GF32635@dualathlon.random> <1102108206.13353.263.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102108206.13353.263.camel@tglx.tec.linutronix.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 10:10:06PM +0100, Thomas Gleixner wrote:
> On Fri, 2004-12-03 at 00:35 +0100, Andrea Arcangeli wrote:
> > Fork eventually failing is very reasonable if you're executing a fork
> > loop.
> 
> Yes, it's reasonable, but the effect that any consequent command is
> aborted then is not so reasonable.

Did you use the 4k stacks on 2.6 btw?

> Use a forking server, connect a lot of clients and it is real life. :)

;)

> Yes, it was invoked

Ok good.
