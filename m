Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265193AbUBIQ2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 11:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265242AbUBIQ2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 11:28:16 -0500
Received: from galileo.bork.org ([66.11.174.156]:42733 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S265193AbUBIQ2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 11:28:15 -0500
Date: Mon, 9 Feb 2004 11:28:14 -0500
From: Martin Hicks <mort@wildopensource.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: Manfreds patch to distribute boot allocations across nodes
Message-ID: <20040209162814.GP21486@localhost>
References: <20040207042559.GP19011@krispykreme> <20040206210428.17ee63db.akpm@osdl.org> <20040207090634.GQ19011@krispykreme> <20040207110732.4c6ced3f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207110732.4c6ced3f.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, Feb 07, 2004 at 11:07:32AM -0800, Andrew Morton wrote:
> Anton Blanchard <anton@samba.org> wrote:
> >
> >  > Should this not search for the emptiest node?
> > 
> >  Allocating things round robin avoids a hot node where everything ends up
> >  being allocated.
> 
> Have you any performance measurements for this patch?

Any suggestions on what benchmark to run?

I tried the patch on Altix and saw similar balancing that Anton showed.
The machine was a 64-way (32 node) machine with 256GB RAM.

mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296
