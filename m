Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUBXVrV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbUBXVrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:47:20 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:64222 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S262487AbUBXVqn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:46:43 -0500
Date: Tue, 24 Feb 2004 14:46:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: todc_time warings on PPC
Message-ID: <20040224214642.GE1052@smtp.west.cox.net>
References: <Pine.GSO.4.44.0402201409380.23390-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0402201409380.23390-100000@math.ut.ee>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 02:12:48PM +0200, Meelis Roos wrote:

> FYI, there are new warning on PPC while compiling 2.6.3+current BK.
> 
> arch/ppc/syslib/todc_time.c: In function `todc_m48txx_read_val':
> arch/ppc/syslib/todc_time.c:99: warning: passing arg 2 of `outb' makes integer from pointer without a cast
> arch/ppc/syslib/todc_time.c:100: warning: passing arg 2 of `outb' makes integer from pointer without a cast
> arch/ppc/syslib/todc_time.c:101: warning: passing arg 1 of `inb' makes integer from pointer without a cast
> arch/ppc/syslib/todc_time.c: In function `todc_m48txx_write_val':
> arch/ppc/syslib/todc_time.c:107: warning: passing arg 2 of `outb' makes integer from pointer without a cast
> arch/ppc/syslib/todc_time.c:108: warning: passing arg 2 of `outb' makes integer from pointer without a cast
> arch/ppc/syslib/todc_time.c:109: warning: passing arg 2 of `outb' makes integer from pointer without a cast
> arch/ppc/syslib/todc_time.c: In function `todc_mc146818_read_val':
> arch/ppc/syslib/todc_time.c:117: warning: passing arg 2 of `outb' makes integer from pointer without a cast
> arch/ppc/syslib/todc_time.c:118: warning: passing arg 1 of `inb' makes integer from pointer without a cast
> arch/ppc/syslib/todc_time.c: In function `todc_mc146818_write_val':
> arch/ppc/syslib/todc_time.c:124: warning: passing arg 2 of `outb' makes integer from pointer without a cast
> arch/ppc/syslib/todc_time.c:125: warning: passing arg 2 of `outb' makes integer from pointer without a cast

Yes.  This, and some slightly more root-cause issues have been fixed in
the tree Linus pulls from occasionally, and once I grab some more of the
(unrelated to this) ppc64 fixes that ppc32 needs, I'll ask Linus to
pull.  Or ask Paul to ask Linus to pull..

-- 
Tom Rini
http://gate.crashing.org/~trini/
