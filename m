Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266501AbUBLQ1a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 11:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbUBLQ1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 11:27:30 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:55194 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S266501AbUBLQ13
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 11:27:29 -0500
Date: Thu, 12 Feb 2004 09:27:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, amitkale@emsyssoft.com
Subject: Re: [PATCH][6/6] A different KGDB stub
Message-ID: <20040212162727.GO19676@smtp.west.cox.net>
References: <20040212000408.GG19676@smtp.west.cox.net.suse.lists.linux.kernel> <p73wu6syf0n.fsf@verdi.suse.de> <20040212155055.GN19676@smtp.west.cox.net> <20040213040041.3e1ec2c2.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213040041.3e1ec2c2.ak@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 04:00:41AM +0100, Andi Kleen wrote:

> On Thu, 12 Feb 2004 08:50:55 -0700
> Tom Rini <trini@kernel.crashing.org> wrote:
> > 
> > Part of why I'm trying to get this into -mm is so that someone who has
> > the hw and knowledge can try and merge some of the things that the other
> > stubs got right into the stub that every arch can use.
> 
> The kgdb stub in current -mm* does all the things I mentioned correctly.

Yes, and it also makes every arch implement the entire stub and provide
its own serial driver.  Having said that, I'll try and pull out more of
the things that the other stub gets right, but I don't have any x86_64
hw (nor toolchain) so I can't test any of the x86_64 changes I make.

-- 
Tom Rini
http://gate.crashing.org/~trini/
