Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVAYEMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVAYEMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 23:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVAYEMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 23:12:12 -0500
Received: from waste.org ([216.27.176.166]:11168 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261798AbVAYEMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 23:12:10 -0500
Date: Mon, 24 Jan 2005 20:11:45 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH] lib/qsort
Message-ID: <20050125041145.GI12076@waste.org>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de> <20050124201527.GZ12076@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124201527.GZ12076@waste.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 12:15:27PM -0800, Matt Mackall wrote:
> Here are some benchmarks of cycle count averages for 10 runs on the
> same random datasets, interrupts disabled. Percentages are performance
> relative to the glibc algorithm. A bunch of other variants dropped for
> brevity.

I've discovered a bug in this benchmark that gives a big advantage to
a couple of variants I tried. Corrected benchmarks later.

-- 
Mathematics is the supreme nostalgia of our time.
