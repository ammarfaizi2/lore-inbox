Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbTDZUTc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 16:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTDZUTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 16:19:31 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:35478 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263018AbTDZUTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 16:19:31 -0400
Date: Sat, 26 Apr 2003 22:31:36 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: missing #includes?
Message-ID: <20030426203136.GA3456@wohnheim.fh-wedel.de>
References: <20030425235119.6f337e70.randy.dunlap@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030425235119.6f337e70.randy.dunlap@verizon.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 April 2003 23:51:19 -0700, Randy.Dunlap wrote:
> 
> I wrote a trivial bash script to check if <sourcefiles> #include
> <headerfile> when <symbol> is used.   Run it at top of kernel tree,
> like so:
> 
> $ check-header  STACK_MAGIC   linux/kernel.h
> error: linux/kernel.h not found in ./arch/h8300/kernel/traps.c
> 
> 
> What's the preferred thing to do here?  I would like to see explicit
> #includes when symbols are used.  Is that what others expect also?
> 
> However, it makes for quite a large list of missing includes.

As long as it doesn't change the kernel binary, I don't have a strong
opinion. Explicit #includes are nicer, but is it worth the trouble?
Do the implicit #includes hurt anywhere? I don't know.

Jörn

-- 
Those who come seeking peace without a treaty are plotting.
-- Sun Tzu
