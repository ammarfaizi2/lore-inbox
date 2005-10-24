Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbVJXOr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbVJXOr4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 10:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVJXOr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 10:47:56 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:2765 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750827AbVJXOr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 10:47:56 -0400
Date: Mon, 24 Oct 2005 07:47:38 -0700
From: Paul Jackson <pj@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       clameter@sgi.com, torvalds@osdl.org, ak@suse.de
Subject: Re: [PATCH 02/02] cpuset automatic numa mempolicy rebinding
Message-Id: <20051024074738.4f2bfcbc.pj@sgi.com>
In-Reply-To: <1130142987.16002.4.camel@localhost>
References: <20051024072744.10390.35722.sendpatchset@jackhammer.engr.sgi.com>
	<20051024072750.10390.32993.sendpatchset@jackhammer.engr.sgi.com>
	<1130142987.16002.4.camel@localhost>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave wrote:
> Just think how that looks to a reviewer without the full context :)

I was just copying Andi's coding style for these cases, with
this BUG() if no policy matched.  When in Rome, do as the
Romans.

> Perhaps the MBOL_BIND case needs a little helper function.

Eh ... that entire routine still fits on a page of my screen.
I'm not sure that adding a helper function would clarify the
code any.

Thanks for looking at it.  If you're pretty sure I should change
one of the above, squeek a little louder.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
