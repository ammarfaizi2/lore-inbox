Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264818AbUD1O6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264818AbUD1O6x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbUD1O6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:58:53 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:41655 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S264818AbUD1O6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:58:51 -0400
Date: Wed, 28 Apr 2004 07:58:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 PATCH] PPC32: compile error in signal.c
Message-ID: <20040428145850.GG3731@smtp.west.cox.net>
References: <Pine.GSO.4.44.0404281025070.7699-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0404281025070.7699-100000@math.ut.ee>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 10:29:26AM +0300, Meelis Roos wrote:

>   CC      arch/ppc/kernel/signal.o
> arch/ppc/kernel/signal.c: In function `handle_signal':
> arch/ppc/kernel/signal.c:518: error: `newspp' undeclared (first use in this function)
> arch/ppc/kernel/signal.c:518: error: (Each undeclared identifier is reported only once
> arch/ppc/kernel/signal.c:518: error: for each function it appears in.)
> arch/ppc/kernel/signal.c:518: warning: long unsigned int format, pointer arg (arg 3)
> 
> The following patch seems to fix it:

It's not quite complete, see http://lkml.org/lkml/2004/4/27/192 (and
akpm has sent this on to Linus already).

-- 
Tom Rini
http://gate.crashing.org/~trini/
