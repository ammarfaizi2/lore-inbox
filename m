Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVEBT4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVEBT4U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 15:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVEBT4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 15:56:20 -0400
Received: from cantor2.suse.de ([195.135.220.15]:32485 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261736AbVEBT4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 15:56:19 -0400
Date: Mon, 2 May 2005 21:56:18 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386: handle iret faults better
Message-ID: <20050502195618.GR7342@wotan.suse.de>
References: <200504290340.j3T3eCcO032218@magilla.sf.frob.com> <Pine.LNX.4.58.0504290941250.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504290941250.18901@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I really ended up deciding that we can fix it with a simple one-liner 
> instead, which actually simplifies and cleans up the code, instead of 
> adding new special cases.
> 
> I just committed the appended, which actually removes one line more than 
> it adds.

Thanks looks great. I will add the equivalent to x86-64.

-Andi
