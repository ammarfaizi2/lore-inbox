Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWA0Kap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWA0Kap (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 05:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWA0Kao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 05:30:44 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:55006 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751439AbWA0Kao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 05:30:44 -0500
Date: Fri, 27 Jan 2006 10:29:22 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] Re: [PATCH 0/9] Reducing fragmentation using zones
 v4
In-Reply-To: <43D96C41.6020103@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.58.0601271027560.25836@skynet>
References: <20060126184305.8550.94358.sendpatchset@skynet.csn.ul.ie>
 <43D96987.8090608@jp.fujitsu.com> <43D96C41.6020103@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2006, KAMEZAWA Hiroyuki wrote:

> KAMEZAWA Hiroyuki wrote:
> > Could you add this patch to your set ?
> > This was needed to boot my x86 machine without HIGHMEM.
> >
> Sorry, I sent a wrong patch..
> This is correct one.

I can add it although I would like to know more about the problem. I tried
booting with and without CONFIG_HIGHMEM both stock kernels and with
anti-frag and they all boot fine. What causes your machine to die? Does it
occur with stock -mm or just with anti-frag?

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
