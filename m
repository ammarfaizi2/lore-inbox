Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262787AbUKRRIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbUKRRIA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUKRRFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:05:41 -0500
Received: from news.suse.de ([195.135.220.2]:55712 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262781AbUKRRDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:03:22 -0500
Date: Thu, 18 Nov 2004 14:22:33 +0100
From: Andi Kleen <ak@suse.de>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Xen 2.0 VMM patches
Message-ID: <20041118132233.GG17532@wotan.suse.de>
References: <p73k6sj221d.fsf@brahms.suse.de> <E1CUjSB-0005II-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CUjSB-0005II-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 10:23:50AM +0000, Ian Pratt wrote:
> The fact that arch xen is self contained actually makes it easier
> for us to maintain in some respects. We've been tracking 2.6
> releases for some time without too much difficulty.

2.6 has been relatively easy for now (because it was supposed
to be a "stable kernel"), but I suspect it'll get worse again over time.
e.g. in 2.5 it was really bad for long times.
Essentially you will need to commit significant man power to this. 

Also it's quite hard to always catch all the changes that
get done to i386.

Overall I think it's a bad idea to have four different
x86 like architectures in the tree. Especially since there
will be likely more hypervisors over time.  i386 and x86-64 make
some sense because 64bit is a natural boundary, but extending
it elsewhere doesn't scale very well.

-Andi

