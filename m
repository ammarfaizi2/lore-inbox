Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266133AbUIIU52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266133AbUIIU52 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUIIUyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:54:53 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:27581 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S266133AbUIIUwh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:52:37 -0400
Date: Thu, 9 Sep 2004 16:51:53 -0400
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs-2.6.9-rc1-mm4.patch
Message-ID: <20040909205153.GA1014@yoda.timesys>
References: <20040908143143.A32002@infradead.org> <Pine.LNX.4.53.0409080938470.15087@montezuma.fsmlabs.com> <1094652572.2800.14.camel@laptop.fenrus.com> <20040908182509.GA6009@elte.hu> <20040908211415.GA20168@elte.hu> <20040909175748.A12336@infradead.org> <20040909172401.GA28376@elte.hu> <20040909175314.GD3106@holomorphy.com> <20040909175441.GA25686@devserv.devel.redhat.com> <20040909211038.E6434@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909211038.E6434@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 09:10:38PM +0100, Russell King wrote:
> If it uses irq_desc then ARM won't use it.  irq_desc is part of the
> far-too-restrictive x86 IRQ handlign code which is unsuitable for
> ARM platforms.

What does ARM need that irq_desc doesn't provide, and which could not
be added?  IMHO, it'd be better to fix the generic code than maintain
completely separate implementations.

-Scott
