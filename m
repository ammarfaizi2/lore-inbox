Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317169AbSGVNkR>; Mon, 22 Jul 2002 09:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317171AbSGVNkQ>; Mon, 22 Jul 2002 09:40:16 -0400
Received: from verein.lst.de ([212.34.181.86]:10764 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S317169AbSGVNkQ>;
	Mon, 22 Jul 2002 09:40:16 -0400
Date: Mon, 22 Jul 2002 15:43:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
Message-ID: <20020722154315.A18998@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Ingo Molnar <mingo@elte.hu>, Russell King <rmk@arm.linux.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
References: <20020722152645.A18695@lst.de> <Pine.LNX.4.44.0207221537450.8903-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207221537450.8903-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Jul 22, 2002 at 03:38:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 03:38:29PM +0200, Ingo Molnar wrote:
> > but not with irq_restore :)  maybe irq_restore_on() although the on is
> > implicit.
> 
> think about it - if this was true then irq_restore_on() would be
> equivalent to irq_on().

yupp, you're right.  could you take the prototype changes anyway?

