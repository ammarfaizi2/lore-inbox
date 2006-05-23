Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWEWQip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWEWQip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 12:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWEWQio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 12:38:44 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:1241 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750816AbWEWQio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 12:38:44 -0400
Date: Tue, 23 May 2006 09:38:29 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: chrisw@sous-sol.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset: remove extra cpuset_zone_allowed check in
 __alloc_pages
Message-Id: <20060523093829.84c50ee5.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0605230929070.9765@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081010440.2648@schroedinger.engr.sgi.com>
	<20060522182356.fbea4aec.pj@sgi.com>
	<Pine.LNX.4.64.0605221858250.7165@schroedinger.engr.sgi.com>
	<20060522192248.b114fea3.pj@sgi.com>
	<Pine.LNX.4.64.0605221925350.7272@schroedinger.engr.sgi.com>
	<20060523063500.GB18769@moss.sous-sol.org>
	<Pine.LNX.4.64.0605230929070.9765@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> Simply removing my patch from mm will do the same.

I doubt it.

Looks to me like your patch went into Linus's tree on March 24, 2006:

    changeset:   23661:1541c55e5f8d
    user:        Christoph Lameter <clameter@engr.sgi.com>
    date:        Fri Mar 24 23:33:22 2006 +0800
    summary:     [PATCH] cpusets: only wakeup kswapd for zones in the current cpuset

If that's so, then only a reversing patch will suffice.  Linus does not
remove patches from his tree; he only adds more patches.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
