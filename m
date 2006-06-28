Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030478AbWF1Ijn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbWF1Ijn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 04:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbWF1Ijn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 04:39:43 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:5801
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030478AbWF1Ijm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 04:39:42 -0400
Date: Wed, 28 Jun 2006 01:39:40 -0700 (PDT)
Message-Id: <20060628.013940.41192890.davem@davemloft.net>
To: mingo@elte.hu
Cc: tglx@linutronix.de, akpm@osdl.org, bunk@stusta.de,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [patch] genirq: rename desc->handler to desc->chip, sparc64 fix
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060628083008.GA14056@elte.hu>
References: <1151479204.25491.491.camel@localhost.localdomain>
	<20060628081345.GA12647@elte.hu>
	<20060628083008.GA14056@elte.hu>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Date: Wed, 28 Jun 2006 10:30:08 +0200

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > > OK, so I moved the above lines inside #ifdef CONFIG_GENERIC_HARDIRQS (diff
> > > > did a strange-looking thing with it):
> > > 
> > > Yeah, but its nevertheless correct. :)
> > 
> > lets hope it builds sparc64 & co too.
> > 
> > /me goes to try
> 
> ok, sparc64 needed the rename fix below, but otherwise it built fine on 
> -mm3.

Thanks Ingo.

Can we get the genirq stuff into Linus's tree soon?  I'm touching
a lot of stuff in this area on sparc64 right now :)
