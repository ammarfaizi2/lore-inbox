Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSGVNXr>; Mon, 22 Jul 2002 09:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315536AbSGVNXr>; Mon, 22 Jul 2002 09:23:47 -0400
Received: from verein.lst.de ([212.34.181.86]:64523 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S315442AbSGVNXq>;
	Mon, 22 Jul 2002 09:23:46 -0400
Date: Mon, 22 Jul 2002 15:26:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
Message-ID: <20020722152645.A18695@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Ingo Molnar <mingo@elte.hu>, Russell King <rmk@arm.linux.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
References: <20020722152056.A18619@lst.de> <Pine.LNX.4.44.0207221521170.7711-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207221521170.7711-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Jul 22, 2002 at 03:23:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 03:23:40PM +0200, Ingo Molnar wrote:
> i agree mostly, but i do not agree with __irq_save() and irq_save().  
> What's wrong with "flags_t irq_save_off()" - the name carries the proper
> meaning, and it also harmonizes with irq_off().

but not with irq_restore :)  maybe irq_restore_on() although the on
is implicit.
