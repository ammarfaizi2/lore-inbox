Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264770AbUFLNLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbUFLNLw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 09:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264771AbUFLNLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 09:11:52 -0400
Received: from colin2.muc.de ([193.149.48.15]:2575 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264770AbUFLNLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 09:11:51 -0400
Date: 12 Jun 2004 15:11:49 +0200
Date: Sat, 12 Jun 2004 15:11:49 +0200
From: Andi Kleen <ak@muc.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andi Kleen <ak@muc.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Permit inode & dentry hash tables to be allocated > MAX_ORDER size
Message-ID: <20040612131149.GA28870@colin2.muc.de>
References: <263jX-5RZ-19@gated-at.bofh.it> <262nZ-56Z-5@gated-at.bofh.it> <263jX-5RZ-17@gated-at.bofh.it> <m3d645fwxj.fsf@averell.firstfloor.org> <1087025760.18615.3.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087025760.18615.3.camel@nighthawk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since vmalloc() maps the pages with small pagetable entries (unlike most
> of the rest of the kernel address space), do you think the interleaving
> will outweigh any negative TLB effects?  

I think so, yes (assuming you run the benchmark on all CPUs)

-Andi
