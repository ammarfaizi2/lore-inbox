Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267608AbUBTGoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 01:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267636AbUBTGoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 01:44:19 -0500
Received: from dp.samba.org ([66.70.73.150]:19348 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267608AbUBTGoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 01:44:16 -0500
Date: Fri, 20 Feb 2004 17:42:28 +1100
From: Anton Blanchard <anton@samba.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] ppc64: fix debugger() warnings
Message-ID: <20040220064228.GB20022@krispykreme>
References: <200402190609.i1J69Hhl001602@hera.kernel.org> <1077214972.9115.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077214972.9115.4.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +static inline int debugger(struct *pt_regs regs) { return 0; }
> > +static inline int debugger_bpt(struct *pt_regs regs) { return 0; }
> > +static inline int debugger_sstep(struct *pt_regs regs) { return 0; }
> 
> I guess these work a LOT better if you type them as "struct pt_regs
> *regs) instead of 'struct *pt_regs regs'

Wow thats some impressively shit coding on my part :) Thanks for
catching it.

Anton
