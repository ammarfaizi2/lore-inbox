Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUGXTgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUGXTgN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 15:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUGXTgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 15:36:13 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:37329 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262328AbUGXTgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 15:36:09 -0400
Subject: Re: [ANNOUNCE] ketchup 0.8
From: Lee Revell <rlrevell@joe-job.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040724031453.GQ18675@waste.org>
References: <20040723185504.GJ18675@waste.org>
	 <1090632808.1471.20.camel@mindpipe> <20040724020644.GN18675@waste.org>
	 <1090638263.1471.24.camel@mindpipe>  <20040724031453.GQ18675@waste.org>
Content-Type: text/plain
Message-Id: <1090697770.845.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Jul 2004 15:36:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-23 at 23:14, Matt Mackall wrote:
> On Fri, Jul 23, 2004 at 11:04:24PM -0400, Lee Revell wrote:
> > On Fri, 2004-07-23 at 22:06, Matt Mackall wrote:
> > > Oops. Should be fixed by:
> > > 
> > > http://selenic.com/ketchup/ketchup-0.8.1
> > 
> > Now it seems to work, but I get:
> > 
> > ...downloads some stuff...
> > patching file sound/pci/intel8x0.c
> > patching file sound/pci/nm256/nm256.c
> > patching file sound/ppc/pmac.c
> > ketchup: patch /home/rlrevell/.ketchup/patch-2.6.8-rc1.bz2 failed: 256
> > 
> > Not checking the return value from patch correctly?
> 
> That return code suggests some hunks failed. Can you check for .rej
> files?

There were no .rej files.  I ran it again and it said I was up to date. 
Is it possible that a mirror was not fully synced?

The easy fix would be to have it just try again automatically if it sees
this.

Lee

