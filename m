Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUBYWnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbUBYWjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:39:53 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:5301 "EHLO fed1mtao08.cox.net")
	by vger.kernel.org with ESMTP id S261663AbUBYWhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:37:31 -0500
Date: Wed, 25 Feb 2004 15:37:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Amit S. Kale" <akale@users.sourceforge.net>
Subject: Re: 3/3 kgdb over netpoll
Message-ID: <20040225223730.GL1052@smtp.west.cox.net>
References: <20040222160849.GA9563@elf.ucw.cz> <20040225215240.GE3883@waste.org> <20040225221246.GH1307@elf.ucw.cz> <20040225221719.GF3883@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225221719.GF3883@waste.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 04:17:19PM -0600, Matt Mackall wrote:

> On Wed, Feb 25, 2004 at 11:12:46PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > This is kgdb-over-ethernet patch. Depends on netpoll, and is somehow
> > > > experimental.
> > > 
> > > Please pick up the current kgdboe docs from -mm.
> > 
> > I'll try to get some docs there, unfortunately this uses completely
> > different command line format, so it is not matter of simple copy.
> 
> Uh, it's based on netpoll but doesn't use the netpoll parser?!

kgdboe is the same.  There are other bits, which are not. (kgdbwait and
gdb both stop the kernel, kgdb8250=N,BAUD).

-- 
Tom Rini
http://gate.crashing.org/~trini/
