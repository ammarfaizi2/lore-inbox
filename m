Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbULXSXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbULXSXI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 13:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbULXSXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 13:23:08 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:15588 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261425AbULXSW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 13:22:59 -0500
Date: Fri, 24 Dec 2004 19:22:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, akpm@osdl.org
Subject: Re: VM fixes [4/4]
Message-ID: <20041224182219.GH13747@dualathlon.random>
References: <20041224174156.GE13747@dualathlon.random> <20041224100147.32ad4268.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041224100147.32ad4268.davem@davemloft.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2004 at 10:01:47AM -0800, David S. Miller wrote:
> On Fri, 24 Dec 2004 18:41:56 +0100
> Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > + * All archs should support atomic ops with
> > + * 1 byte granularity.
> > + */
> > +	unsigned char memdie;
> 
> Again, older Alpha's do not.

If those old cpus really supported smp in linux, then fixing this bit is
trivial, just change it to short. Do they support short at least?

Thanks.
