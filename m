Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265617AbUATSTc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265624AbUATSTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:19:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:11235 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265617AbUATSTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:19:25 -0500
Date: Tue, 20 Jan 2004 10:19:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] -mm5 has no i2c on amd64
Message-Id: <20040120101945.0e23b655.akpm@osdl.org>
In-Reply-To: <p73n08ihj25.fsf@verdi.suse.de>
References: <20040120124626.GA20023@bytesex.org.suse.lists.linux.kernel>
	<p73n08ihj25.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> Gerd Knorr <kraxel@bytesex.org> writes:
> > 
> > ==============================[ cut here ]==============================
> > --- linux-mm5-2.6.1/arch/x86_64/Kconfig.i2c	2004-01-20 13:14:42.000000000 +0100
> > +++ linux-mm5-2.6.1/arch/x86_64/Kconfig	2004-01-20 13:15:10.000000000 +0100
> > @@ -429,6 +429,8 @@
> >  
> >  source "drivers/char/Kconfig"
> >  
> > +source "drivers/i2c/Kconfig"
> > +
> 
> There is no such source in arch/i386/Kconfig.  So it's probably wrong.
> 

arch/i386/Kconfig sources drivers/Kconfig, which then picks up the i2c stuff.

