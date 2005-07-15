Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263251AbVGOI65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263251AbVGOI65 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 04:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263252AbVGOI6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 04:58:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263248AbVGOI5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 04:57:35 -0400
Date: Fri, 15 Jul 2005 01:56:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1
Message-Id: <20050715015629.7b0fb13a.akpm@osdl.org>
In-Reply-To: <20050715094947.E25428@flint.arm.linux.org.uk>
References: <20050715013653.36006990.akpm@osdl.org>
	<20050715094947.E25428@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Fri, Jul 15, 2005 at 01:36:53AM -0700, Andrew Morton wrote:
> > +uart_handle_sysrq_char-warning-fix.patch
> > 
> >  Fix a warning
> 
> Andrew, this requires a little more fixing than your simple patch.
> Several drivers omit 'regs' from the receive handler when sysrq is
> not enabled.  Hence, this simple fix on its own will cause compile
> failures.

Me no understand.  It replaces a three-arg macro with a three-arg static
inline?
