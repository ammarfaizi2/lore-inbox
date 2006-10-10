Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWJJQJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWJJQJR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWJJQJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:09:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18914 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932182AbWJJQJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:09:15 -0400
Subject: Re: [rfc] 2.6.19-rc1-git5: consolidation of file backed fault
	handlers
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061010150142.GE2431@wotan.suse.de>
References: <20061010121314.19693.75503.sendpatchset@linux.site>
	 <20061010143342.GA5580@infradead.org> <20061010150142.GE2431@wotan.suse.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 10 Oct 2006 18:09:06 +0200
Message-Id: <1160496546.3000.315.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> \ What:	vm_ops.nopage
> -When:	October 2008, provided in-kernel callers have been converted
> +When:	October 2007, provided in-kernel callers have been converted
>  Why:	This interface is replaced by vm_ops.fault, but it has been around
>  	forever, is used by a lot of drivers, and doesn't cost much to
>  	maintain.

but a year is a really long time; 6 months would be a lot more
reasonable..
(it's not as if most external modules will switch until it's really
gone.. more notice isn't really going to help that at all; at least make
the kernel printk once on the first use of this so that they notice!)


