Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbTEaPDA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 11:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264475AbTEaPC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 11:02:59 -0400
Received: from ns.suse.de ([213.95.15.193]:46090 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264453AbTEaPC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 11:02:58 -0400
Date: Sat, 31 May 2003 17:16:19 +0200
From: Andi Kleen <ak@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Exception trace for i386, mark II
Message-ID: <20030531151619.GA26552@wotan.suse.de>
References: <20030531121008$2041@gated-at.bofh.it> <200305311512.h4VFCHhj010685@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305311512.h4VFCHhj010685@post.webmailer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 04:39:37PM +0200, Arnd Bergmann wrote:
> Andi Kleen wrote:
> 
> > 
> > This is a new implementation of exception trace for i386.
> > 
> > It adds a new exception-trace sysctl (default to off), which when enabled
> > triggers printk for unhandled fault signals (SIGSEGV etc.). 
> 
> Isn't this very similar to the KERN_S390_USER_DEBUG_LOGGING sysctl?
> Maybe the code can be merged, or at least they can use the same
> numeric value for the sysctl.

No problem from my side, although it seems a bit pointless for just 
an sysctl.  I don't think anybody expects new sysctls binary values to be stable
anymore - all the distribution kernels vary them widely.

-Andi
