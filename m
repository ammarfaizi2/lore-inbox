Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUG2L44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUG2L44 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 07:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUG2L44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 07:56:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26240 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264389AbUG2L4z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 07:56:55 -0400
Date: Thu, 29 Jul 2004 07:57:55 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Chris Caputo <ccaputo@alt.net>, linux-kernel@vger.kernel.org
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
Message-ID: <20040729105755.GA6897@logos.cnet>
References: <20040729002535.GA5145@logos.cnet> <Pine.LNX.4.44.0407282325460.30510-100000@nacho.alt.net> <20040729075429.GA15700@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729075429.GA15700@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 09:54:29AM +0200, Arjan van de Ven wrote:
> On Wed, Jul 28, 2004 at 11:27:41PM -0700, Chris Caputo wrote:
> > On Wed, 28 Jul 2004, Marcelo Tosatti wrote:
> > > Changing the affinity writes new values to the IOAPIC registers, I can't see
> > > how that could interfere with the atomicity of a spinlock operation. I dont
> > > understand why you think irqbalance could affect anything.
> > 
> > Because when I stop running irqbalance the crashes no longer happen.
> 
> what is the irq distribution when you do that?
> Can you run irqbalance for a bit to make sure there's a static distribution
> of irq's and then disable it and see if it survives ?

Chris, Yes I'm also running irqbalance. 

Arjan, what is an easy way for me to make irqbalance change the affinity
as crazy on the SMP 8way box, just for a test?

TIA


