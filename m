Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423226AbWF1Ive@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423226AbWF1Ive (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 04:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423227AbWF1Ive
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 04:51:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10652 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423226AbWF1Ivd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 04:51:33 -0400
Date: Wed, 28 Jun 2006 01:48:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: mingo@elte.hu, tglx@linutronix.de, bunk@stusta.de,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [patch] genirq: rename desc->handler to desc->chip, sparc64 fix
Message-Id: <20060628014807.0694436f.akpm@osdl.org>
In-Reply-To: <20060628.013940.41192890.davem@davemloft.net>
References: <1151479204.25491.491.camel@localhost.localdomain>
	<20060628081345.GA12647@elte.hu>
	<20060628083008.GA14056@elte.hu>
	<20060628.013940.41192890.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 01:39:40 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> Date: Wed, 28 Jun 2006 10:30:08 +0200
> 
> > 
> > * Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > > > OK, so I moved the above lines inside #ifdef CONFIG_GENERIC_HARDIRQS (diff
> > > > > did a strange-looking thing with it):
> > > > 
> > > > Yeah, but its nevertheless correct. :)
> > > 
> > > lets hope it builds sparc64 & co too.
> > > 
> > > /me goes to try
> > 
> > ok, sparc64 needed the rename fix below, but otherwise it built fine on 
> > -mm3.
> 
> Thanks Ingo.
> 
> Can we get the genirq stuff into Linus's tree soon?

I'm thinking Thursday/Fridayish.  Is that OK?
