Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUGXDO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUGXDO6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 23:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268254AbUGXDO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 23:14:57 -0400
Received: from waste.org ([209.173.204.2]:32210 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264658AbUGXDOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 23:14:55 -0400
Date: Fri, 23 Jul 2004 22:14:53 -0500
From: Matt Mackall <mpm@selenic.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] ketchup 0.8
Message-ID: <20040724031453.GQ18675@waste.org>
References: <20040723185504.GJ18675@waste.org> <1090632808.1471.20.camel@mindpipe> <20040724020644.GN18675@waste.org> <1090638263.1471.24.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090638263.1471.24.camel@mindpipe>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 11:04:24PM -0400, Lee Revell wrote:
> On Fri, 2004-07-23 at 22:06, Matt Mackall wrote:
> > Oops. Should be fixed by:
> > 
> > http://selenic.com/ketchup/ketchup-0.8.1
> 
> Now it seems to work, but I get:
> 
> ...downloads some stuff...
> patching file sound/pci/intel8x0.c
> patching file sound/pci/nm256/nm256.c
> patching file sound/ppc/pmac.c
> ketchup: patch /home/rlrevell/.ketchup/patch-2.6.8-rc1.bz2 failed: 256
> 
> Not checking the return value from patch correctly?

That return code suggests some hunks failed. Can you check for .rej
files?

-- 
Mathematics is the supreme nostalgia of our time.
