Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbUAWWHM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 17:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUAWWHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 17:07:12 -0500
Received: from CPE0080c6f0a1ca-CM014280009361.cpe.net.cable.rogers.com ([24.157.199.55]:3076
	"EHLO stargazer") by vger.kernel.org with ESMTP id S266622AbUAWWHJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 17:07:09 -0500
Date: Fri, 23 Jan 2004 17:09:58 -0500
From: Glenn Wurster <gwurster@scs.carleton.ca>
To: Alan Cox <alan@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, andre@linux-ide.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] ide-dma.c, ide.c, ide.h, kernel 2.4.24
Message-ID: <20040123220958.GA891@desktop>
References: <20040123183245.GB853@desktop> <20040123213329.GH22615@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123213329.GH22615@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Brief Synopsis:
> > 
> > IDE initialization on non-DMA controllers causes OOPS during boot
> > due to dereference of null function pointers.
> 
> Linus - I am ok with this but for 2.6 Bart needs to look at it I guess

I tried out the 2.6.1 kernel quickly and it did not exhibit the same
obvious problems oopsing with dma and the ide controller as the latest
2.4 kernels (on my hardware at least).  It booted up nicely without a
problem on unmodified source.  Whether or not the problem occurs for
other types of hardware I can't say.

Glenn.
