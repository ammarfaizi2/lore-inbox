Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267134AbUBSJwu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 04:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267149AbUBSJwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 04:52:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:5334 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267134AbUBSJwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 04:52:49 -0500
Date: Thu, 19 Feb 2004 01:52:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: jgarzik@pobox.com, rmk+lkml@arm.linux.org.uk, aahrend@web.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6: No hot_UN_plugging of PCMCIA network cards
Message-Id: <20040219015216.6055b65a.akpm@osdl.org>
In-Reply-To: <1077183550.802.3.camel@teapot.felipe-alfaro.com>
References: <20040122210501.40800ea7.aahrend@web.de>
	<20040122213757.H23535@flint.arm.linux.org.uk>
	<20040123232025.4a128ead.aahrend@web.de>
	<20040124004530.B25466@flint.arm.linux.org.uk>
	<4034016C.5070307@pobox.com>
	<1077183550.802.3.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
>
>  I've been experiencing hangs with -mm kernels and my CardBus 3Com NIC
>  when resuming from APM suspend to disk which seem to be caused by the
>  3c59x driver. The hang just gets resolved by unplugging, then plugging
>  the CardBus NIC. This doesn't happen with vanilla tree, however.
> 
>  I've found that reverting 3c9x-enable_wol.patch fixes this situation for
>  me.

Sigh.  Cannot you add the enable_wol module parameter?  
