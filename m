Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264298AbUG2G1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUG2G1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 02:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUG2G1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 02:27:47 -0400
Received: from nacho.alt.net ([207.14.113.18]:16561 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S264298AbUG2G1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 02:27:46 -0400
Date: Wed, 28 Jul 2004 23:27:41 -0700 (PDT)
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Arjan van de Ven <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
In-Reply-To: <20040729002535.GA5145@logos.cnet>
Message-ID: <Pine.LNX.4.44.0407282325460.30510-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004, Marcelo Tosatti wrote:
> Changing the affinity writes new values to the IOAPIC registers, I can't see
> how that could interfere with the atomicity of a spinlock operation. I dont
> understand why you think irqbalance could affect anything.

Because when I stop running irqbalance the crashes no longer happen.

Chris

