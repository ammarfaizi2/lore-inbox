Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVA0Xup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVA0Xup (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVA0XuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:50:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:24543 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261292AbVA0Xar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:30:47 -0500
Date: Thu, 27 Jan 2005 15:35:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: mauriciolin@gmail.com, tglx@linutronix.de, marcelo.tosatti@cyclades.com,
       edjard@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: User space out of memory approach
Message-Id: <20050127153535.7cc94c10.akpm@osdl.org>
In-Reply-To: <20050127225854.GZ8518@opteron.random>
References: <3f250c71050121132713a145e3@mail.gmail.com>
	<3f250c7105012113455e986ca8@mail.gmail.com>
	<20050122033219.GG11112@dualathlon.random>
	<3f250c7105012513136ae2587e@mail.gmail.com>
	<1106689179.4538.22.camel@tglx.tec.linutronix.de>
	<3f250c71050125161175234ef9@mail.gmail.com>
	<20050126004901.GD7587@dualathlon.random>
	<3f250c7105012710541d3e7ad1@mail.gmail.com>
	<20050127221129.GX8518@opteron.random>
	<20050127142943.3fea07df.akpm@osdl.org>
	<20050127225854.GZ8518@opteron.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> And they had not necessairly hardware access. They "might" have hardware
> access.

On x86 we could perhaps test for non-nullness of tsk->thread->io_bitmap_ptr?

> I thought I could wait the other patches
> to be merged to avoid confusion before making more changes (since it'd
> be a pretty self contained feature), but I can do that now if you
> prefer.

I'll send your current stuff off to Linus in the next few days - we can let
that sit for a while, use that as a base for further work.

