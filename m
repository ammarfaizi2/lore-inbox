Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266592AbUGKNs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266592AbUGKNs5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 09:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266596AbUGKNs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 09:48:57 -0400
Received: from ozlabs.org ([203.10.76.45]:5030 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266592AbUGKNs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 09:48:56 -0400
Date: Sun, 11 Jul 2004 21:09:20 +1000
From: Anton Blanchard <anton@samba.org>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Andrey Panin <pazke@donpac.ru>
Subject: Re: Moving per-arch IRQ handling code into common directories
Message-ID: <20040711110919.GI5232@krispykreme>
References: <16602.9814.700745.300562@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16602.9814.700745.300562@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

>   Inside each arch-specific kernel/irq.c, there's a comment something like, 
>   /* (mostly architecture independent, will move to kernel/irq.c in 2.5.) */
> 
> This obviously hasn't happened, even though there was a patch by
> Andrey Panin floating about around a year ago.  Is there some
> fundamental objection to consolidating the IRQ handling as far as
> possible, or was it just that the patch didn't get high enough profile?

I think it died because we were in a freeze at the time. Id like to see
it happen again, perhaps we can get something together to go into -mm.

Anton
