Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbVBCKxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbVBCKxF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbVBCKxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:53:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:38838 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262940AbVBCKwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:52:00 -0500
Date: Thu, 3 Feb 2005 02:51:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: tglx@linutronix.de, davej@redhat.com, torvalds@osdl.org,
       dwmw2@infradead.org, albert_herranz@yahoo.es,
       linux-kernel@vger.kernel.org
Subject: Re: ppc32 MMCR0_PMXE saga.
Message-Id: <20050203025125.02b88fb5.akpm@osdl.org>
In-Reply-To: <16898.9.429645.633109@alkaid.it.uu.se>
References: <20050203044702.GA1089@redhat.com>
	<1107413930.21196.637.camel@tglx.tec.linutronix.de>
	<16898.9.429645.633109@alkaid.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> Thomas Gleixner writes:
>   > On Wed, 2005-02-02 at 23:47 -0500, Dave Jones wrote:
>   > > I'm at a loss to explain whats been happening with this symbol.
>   > 
>   > The macro was duplicated in -mm1.
>   > I sent a patch against -mm1
>   > The patch went upstream without the perfctr-ppc.patch, which contained
>   > the macro define in regs.h.
>   > 
>   > So a bit of confusion came up
> 
>  The sane thing to do is to split -mm's perfctr-ppc.patch so that
>  the new symbolic constants can go into -linus w/o having to drag
>  in the experimental perfctr stuff from -mm.

ah, so that's what happened.

I'll tweak perfctr-ppc.patch for now.
