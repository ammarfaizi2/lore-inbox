Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVAPQTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVAPQTE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 11:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVAPQTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 11:19:04 -0500
Received: from [213.146.154.40] ([213.146.154.40]:7369 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262532AbVAPQSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 11:18:47 -0500
Date: Sun, 16 Jan 2005 16:18:37 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Bird <tim.bird@am.sony.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050116161836.GB26144@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tim Bird <tim.bird@am.sony.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <20050114002352.5a038710.akpm@osdl.org> <1105742791.13265.3.camel@tglx.tec.linutronix.de> <41E8543A.8050304@am.sony.com> <1105748656.13265.90.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105748656.13265.90.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 01:24:16AM +0100, Thomas Gleixner wrote:
> Putting a 200k patch into the kernel for limited usage and maybe
> restricting a generic simple non intrusive and more generic
> implementation by its mere presence is making it inapplicable enough.
> 
> Merge the instrumentation points from ltt and other projects like DSKI
> and the places where in kernel instrumentation for specific purposes is
> already available and use a simple and effective framework which moves
> the burden into postprocessing and provides a simple postmortem dump
> interface, is the goal IMHO.
> 
> When this is available, trace tool developers can concentrate on
> postprocessing improvement rather than moving postprocessing
> incapabilities into the kernel.

I completely agree with that statement.  We've been working in most
areas of the kernel to move or keep complexity and policy in userspace.
The same should be true for a tracing framework.

