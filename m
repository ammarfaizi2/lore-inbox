Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266692AbUBFWfZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 17:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266809AbUBFWfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 17:35:25 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:8676 "EHLO fed1mtao07.cox.net")
	by vger.kernel.org with ESMTP id S266692AbUBFWfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 17:35:19 -0500
Date: Fri, 6 Feb 2004 15:35:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: akpm@osdl.org, george@mvista.com, amitkale@emsyssoft.com,
       Andi Kleen <ak@suse.de>, jim.houston@comcast.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitKeeper repo for KGDB
Message-ID: <20040206223517.GD5219@smtp.west.cox.net>
References: <20040127184029.GI32525@stop.crashing.org> <20040128165104.GC1200@elf.ucw.cz> <20040128170520.GI6577@stop.crashing.org> <20040128174402.GI340@elf.ucw.cz> <20040128175646.GJ6577@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128175646.GJ6577@stop.crashing.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 10:56:47AM -0700, Tom Rini wrote:
> On Wed, Jan 28, 2004 at 06:44:02PM +0100, Pavel Machek wrote:
[snip]
> > It's against 2.6 + -netpoll + Amit's patch.
> 
> But doesn't -mm have a kgdb over enet driver that does work?  It's just
> not been ported to Amit's bits, right?

OK.  Based on this, and some other fixes, I've pushed my first cut of
KGDB over ethernet.  It's not quite as robust as I'd like right now (I'm
still getting it just-right for connecting live), and I've got some not
quite finished improvements still locally, but it does work.

-- 
Tom Rini
http://gate.crashing.org/~trini/
