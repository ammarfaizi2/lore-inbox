Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVHEXaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVHEXaL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 19:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVHEXaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 19:30:11 -0400
Received: from imap.gmx.net ([213.165.64.20]:17545 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261915AbVHEXaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 19:30:09 -0400
X-Authenticated: #1725425
Date: Sat, 6 Aug 2005 01:29:09 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Martin Loschwitz <madkiss@madkiss.org>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: local DDOS? Kernel panic when accessing /proc/ioports
Message-Id: <20050806012909.618810dd.Ballarin.Marc@gmx.de>
In-Reply-To: <20050805215247.GA25652@minerva.local.lan>
References: <20050805192628.GA24706@minerva.local.lan>
	<20050805195056.GB7991@shell0.pdx.osdl.net>
	<20050805215247.GA25652@minerva.local.lan>
X-Mailer: Sylpheed version 2.0.0rc (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2005 23:52:47 +0200
Martin Loschwitz <madkiss@madkiss.org> wrote:

> 
> The situation in this case is somewhat obscene ... Originally, I had exactly
> this problem while using the Knoppix standard kernel (2.6.11 vanilla SMP). I
> then went to compile 2.6.12.3, also with SMP, and it showed exactly the same
> problem. I disable SMP, tried again -- voila, it worked.
> 
> The kernel that I am encountering this error again now is 2.6.12.3 -- without
> SMP or whatsoever. I'm just out of ideas on how to fix it this time.

Did you always use the same machine? If so, can you rule out hardware
issues? Can you reproduce this Oops at will?

I can't reproduce this on various machines (all X86, kernels  2.6.11.9,
2.6.12.2, 2.6.13-rc4-mm1, no SMP)

Regards
