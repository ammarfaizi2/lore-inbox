Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbUCUEgc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 23:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263604AbUCUEgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 23:36:32 -0500
Received: from holomorphy.com ([207.189.100.168]:39818 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263605AbUCUEgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 23:36:31 -0500
Date: Sat, 20 Mar 2004 20:36:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-ID: <20040321043622.GU2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
	haveblue@us.ibm.com, hch@infradead.org
References: <1079651064.8149.158.camel@arrakis> <20040318165957.592e49d3.pj@sgi.com> <1079659184.8149.355.camel@arrakis> <20040318175654.435b1639.pj@sgi.com> <1079737351.17841.51.camel@arrakis> <20040319165928.45107621.pj@sgi.com> <20040320031843.GY2045@holomorphy.com> <20040320000235.5e72040a.pj@sgi.com> <20040320111340.GA2045@holomorphy.com> <20040320201954.65e35bb1.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320201954.65e35bb1.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 08:19:54PM -0800, Paul Jackson wrote:
> Find by me if folks have their dirty laundry.  There are limits to my
> powers to set things right.
> Sorry to have provoked your length explanation of physical_balance, but
> in the version of the kernel that I happened to do my research on,
> 2.6.3-rc1-mm1, this is _dead_ code.  The variable physical_balance is
> never read, just written, and only appears on 3 lines total.
> Obviously if it is in use in current versions of the kernel, then it's
> not dead code anymore (at least not without a more profound
> understanding of what's going on, which I make no claims to).

There's probably something in -mm reducing its use that I haven't
looked at; the digression there was based on mainline.


-- wli
