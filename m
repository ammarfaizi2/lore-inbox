Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVFIOr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVFIOr1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 10:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVFIOr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 10:47:27 -0400
Received: from aun.it.uu.se ([130.238.12.36]:4483 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261156AbVFIOrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 10:47:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17064.22132.219886.207366@alkaid.it.uu.se>
Date: Thu, 9 Jun 2005 16:47:16 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Scott Robert Ladd <lkml@coyotegulch.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Has anyone had problems with GCC 4.0 and the kernel?
In-Reply-To: <42A85065.4000108@coyotegulch.com>
References: <42A85065.4000108@coyotegulch.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Robert Ladd writes:
 > Hello,
 > 
 > I've had several inquiries recently in regard to compiling the kernel
 > with GCC 4.0. It seems folk are having problems, do a Google search, and
 > find my capsule review of GCC 4.0 at:
 > 
 > http://www.coyotegulch.com/reviews/gcc4/index.html
 > 
 > I'm not running a GCC 4.0-created kernel, but I had no problems
 > compiling it and running one a few weeks ago. Before I start looking
 > into this further, has anyone here had problems with GCC 4? Maybe I just
 > hallucinated that it compiled and booted... ;)

gcc-4.0.0 vanilla is broken and miscompiles some ipv4/sysctl stuff.
More recent 4.0.1 snapshots are OK.

I've been using gcc4 for 2.6 and 2.4 kernels since late January,
for both desktops and servers, and for i386/x86-64/ppc/ppc64.
Recent 2.6 kernels should work as-is, except perhaps in poorly
maintained drivers. The 2.4 kernels need fair amounts of patching,
99% of which is to prevent compile-time errors. These patches
are not yet merged into the standard 2.4 tree and may never be.
