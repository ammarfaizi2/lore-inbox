Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268250AbUGXDE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268250AbUGXDE2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 23:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268249AbUGXDE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 23:04:28 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:61657 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268250AbUGXDEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 23:04:25 -0400
Subject: Re: [ANNOUNCE] ketchup 0.8
From: Lee Revell <rlrevell@joe-job.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040724020644.GN18675@waste.org>
References: <20040723185504.GJ18675@waste.org>
	 <1090632808.1471.20.camel@mindpipe>  <20040724020644.GN18675@waste.org>
Content-Type: text/plain
Message-Id: <1090638263.1471.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 23 Jul 2004 23:04:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-23 at 22:06, Matt Mackall wrote:
> On Fri, Jul 23, 2004 at 09:33:28PM -0400, Lee Revell wrote:
> > On Fri, 2004-07-23 at 14:55, Matt Mackall wrote:
> > > ketchup is a script that automatically patches between kernel
> > > versions, downloading and caching patches as needed, and automatically
> > > determining the latest versions of several trees. Available at:
> > > 
> > >  http://selenic.com/ketchup/ketchup-0.8
> > > 
> > 
> > Does not work on Debian unstable:
> 
> Oops. Should be fixed by:
> 
> http://selenic.com/ketchup/ketchup-0.8.1

Now it seems to work, but I get:

...downloads some stuff...
patching file sound/pci/intel8x0.c
patching file sound/pci/nm256/nm256.c
patching file sound/ppc/pmac.c
ketchup: patch /home/rlrevell/.ketchup/patch-2.6.8-rc1.bz2 failed: 256

Not checking the return value from patch correctly?

Lee

