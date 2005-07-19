Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVGSDWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVGSDWY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 23:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVGSDWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 23:22:23 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:17677 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261934AbVGSDWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 23:22:22 -0400
Date: Mon, 18 Jul 2005 20:31:32 -0700
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Chinner <dgc@sgi.com>,
       Nathan Scott <nathans@sgi.com>, Steve Lord <lord@xfs.org>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: RT and XFS
Message-ID: <20050719033132.GB22060@nietzsche.lynx.com>
References: <1121209293.26644.8.camel@dhcp153.mvista.com> <20050713002556.GA980@frodo> <20050713064739.GD12661@elte.hu> <1121273158.13259.9.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050714002246.GA937@frodo> <20050714135023.E241419@melbourne.sgi.com> <1121314226.14816.18.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050715102311.GA5302@elte.hu> <1121444215.19554.18.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121444215.19554.18.camel@c-67-188-6-232.hsd1.ca.comcast.net>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 09:16:55AM -0700, Daniel Walker wrote:
> I don't agree with that. But of course I'm always speaking from a real
> time perspective . PI is expensive , but it won't always be. However, no
> one is forcing PI on anyone, even if I think it's good ..

It depends on what kind of PI under specific circumstances. In the general
kernel, it's really to be avoided at all costs since it's masking a general
contention problem at those places. In a formally provable worst case system
using priority ceiling emulation and stuff, PI really valuable. How a system
like the Linux kernel fits into that is a totally different story. General
purpose kernels using general purpose facilities don't.

That's how I see it.

bill

