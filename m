Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263602AbUCUETh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 23:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263603AbUCUETh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 23:19:37 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:55370 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263602AbUCUETf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 23:19:35 -0500
Date: Sat, 20 Mar 2004 20:19:54 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-Id: <20040320201954.65e35bb1.pj@sgi.com>
In-Reply-To: <20040320111340.GA2045@holomorphy.com>
References: <1079651064.8149.158.camel@arrakis>
	<20040318165957.592e49d3.pj@sgi.com>
	<1079659184.8149.355.camel@arrakis>
	<20040318175654.435b1639.pj@sgi.com>
	<1079737351.17841.51.camel@arrakis>
	<20040319165928.45107621.pj@sgi.com>
	<20040320031843.GY2045@holomorphy.com>
	<20040320000235.5e72040a.pj@sgi.com>
	<20040320111340.GA2045@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This isn't quite dead; physical_balance isn't a local. it's a state
> variable static to io_apic.c and it determines the behavior later after
> boot.

Find by me if folks have their dirty laundry.  There are limits to my
powers to set things right.

Sorry to have provoked your length explanation of physical_balance, but
in the version of the kernel that I happened to do my research on,
2.6.3-rc1-mm1, this is _dead_ code.  The variable physical_balance is
never read, just written, and only appears on 3 lines total.

Obviously if it is in use in current versions of the kernel, then it's
not dead code anymore (at least not without a more profound
understanding of what's going on, which I make no claims to).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
