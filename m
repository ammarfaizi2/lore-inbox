Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTJNW4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 18:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbTJNW4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 18:56:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:17289 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261909AbTJNW4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 18:56:44 -0400
Date: Tue, 14 Oct 2003 15:56:38 -0700
From: cliff white <cliffw@osdl.org>
To: m.fioretti@inwind.it
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unbloating the kernel, action list
Message-Id: <20031014155638.7db76874.cliffw@osdl.org>
In-Reply-To: <16710000.1066170641@flay>
References: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it>
	<20031014214311.GC933@inwind.it>
	<16710000.1066170641@flay>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003 15:30:41 -0700
"Martin J. Bligh" <mbligh@aracnet.com> wrote:

> 
> > 7) Do come in suggesting anything I might have forgotten
> 
> If you do automated testing of nightly builds of the mainline 2.6 / 2.7
> kernels, and point out when they get bigger in consumption, you'll have
> a much better chance of convincing people to fix it when the patch in
> question is still topical, and fresh in people's minds.
> 
> I'd predict that a lot of the issue is just tuning things dynamically 
> instead of statically sizing them.

We (OSDL + others) are working on a continuous build/test system, using the Mozilla tinderbox.
Should be available RSN. Tinderbox supports multiple clients, and we'll
have a client package available for download. 

Marco, if you could supply time on a small client box, and a desired .config,
we can add you as a Tinderbox client,
 then you have a place to point people when the size increases. 

Either way, please send me your desired .config - i can and should 
build a size test into the tinderclient code. 

cliffw

> 
> M.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
