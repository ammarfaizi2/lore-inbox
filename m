Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVJXOxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVJXOxP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 10:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbVJXOxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 10:53:15 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:49038 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750827AbVJXOxO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 10:53:14 -0400
Subject: Re: [PATCH 02/02] cpuset automatic numa mempolicy rebinding
From: Dave Hansen <haveblue@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Simon.Derr@bull.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clameter@sgi.com, Linus Torvalds <torvalds@osdl.org>, ak@suse.de
In-Reply-To: <20051024074738.4f2bfcbc.pj@sgi.com>
References: <20051024072744.10390.35722.sendpatchset@jackhammer.engr.sgi.com>
	 <20051024072750.10390.32993.sendpatchset@jackhammer.engr.sgi.com>
	 <1130142987.16002.4.camel@localhost>  <20051024074738.4f2bfcbc.pj@sgi.com>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 16:52:24 +0200
Message-Id: <1130165544.22707.54.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 07:47 -0700, Paul Jackson wrote:
> Dave wrote:
> > Just think how that looks to a reviewer without the full context :)
> 
> I was just copying Andi's coding style for these cases, with
> this BUG() if no policy matched.  When in Rome, do as the
> Romans.
> 
> > Perhaps the MBOL_BIND case needs a little helper function.
> 
> Eh ... that entire routine still fits on a page of my screen.
> I'm not sure that adding a helper function would clarify the
> code any.
> 
> Thanks for looking at it.  If you're pretty sure I should change
> one of the above, squeek a little louder.

I really just meant it was hard to read having two braces at the same
level.  This was due to the extra block inside of the switch() for the
'case MPOL_BIND:'.  Not a huge deal, but it did cause me a bit of a
brain fault for a moment.

-- Dave

