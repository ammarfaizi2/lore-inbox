Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUCPTcB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbUCPTbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:31:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:59011 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261421AbUCPT2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:28:01 -0500
Date: Tue, 16 Mar 2004 11:34:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Ian Campbell <icampbell@arcom.com>, netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Do not include linux/irq.h from linux/netpoll.h
In-Reply-To: <20040316192247.A7886@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0403161133430.17272@ppc970.osdl.org>
References: <1079369568.19012.100.camel@icampbell-debian>
 <20040316001141.C29594@flint.arm.linux.org.uk> <20040316192247.A7886@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Mar 2004, Russell King wrote:
> > 
> > What are your thoughts on this?
> 
> So how do we solve this problem.  Should I just merge this change and
> ask you to pull it?  I think that's rather impolite though.

I didn't apply the patch because you said it was untested ;)

I'll happily remove that irq.h include if it really doesn't do anything 
but break things. I'd feel happier about it if somebody said it has been 
tested, though ;)

		Linus
