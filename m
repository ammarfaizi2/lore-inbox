Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUIJHXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUIJHXu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 03:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUIJHXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 03:23:48 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:54150 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264213AbUIJHXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 03:23:40 -0400
Date: Fri, 10 Sep 2004 00:23:28 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040910072328.GB4606@taniwha.stupidest.org>
References: <20040909232532.GA13572@taniwha.stupidest.org> <1094798428.2800.3.camel@laptop.fenrus.com> <20040910064519.GA4232@taniwha.stupidest.org> <20040910065213.GA11140@devserv.devel.redhat.com> <20040910071530.GB4480@taniwha.stupidest.org> <20040910072121.GE11140@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910072121.GE11140@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 09:21:21AM +0200, Arjan van de Ven wrote:

> it used to be 8K unified for user context and softirq context and
> hardirq context. Basically that got "split up" into 4k for user and
> 4k each for the irq contexts.

you didn't answer my second question and that's not really an answer
of why 4K is the 'right' value

what makes 4K suitable for i386 when x86-64 uses 8K and ppc64 uses
16K?  the argument used to be about memory fragmentation but that not
solved for the latter

