Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUD2XYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUD2XYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 19:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbUD2XYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 19:24:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:38093 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264668AbUD2XYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 19:24:16 -0400
Date: Thu, 29 Apr 2004 16:26:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: marcelo.tosatti@cyclades.com, jmoyer@redhat.com, carson@taltos.org,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, davem@redhat.com
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Message-Id: <20040429162632.689fa7fe.akpm@osdl.org>
In-Reply-To: <20040429224936.GT29954@dualathlon.random>
References: <382320000.1082759593@taltos.ny.ficc.gs.com>
	<16527.4259.174536.629347@segfault.boston.redhat.com>
	<20040429210951.GB20453@logos.cnet>
	<20040429142807.1fa4c5ea.akpm@osdl.org>
	<20040429224936.GT29954@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Thu, Apr 29, 2004 at 02:28:07PM -0700, Andrew Morton wrote:
> > just to exercise that code path a bit more.
> 
> what's the point of exercising that code path more? are you worried that
> there are bugs in it?

The only application which we know will exercise that code is the distcc
server.  Making that little change while testing the patch will increase
the chance of shaking out any problems.
