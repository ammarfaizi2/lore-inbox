Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWBXQPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWBXQPG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWBXQPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:15:06 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:32698 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932312AbWBXQPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:15:04 -0500
Message-ID: <43FF3055.914C25CA@tv-sign.ru>
Date: Fri, 24 Feb 2006 19:12:05 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Bryan Fink <bfink@eventmonitor.com>,
       linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
       Steven Pratt <slpratt@austin.ibm.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: NFS Still broken in 2.6.x?
References: <43FF24AF.63527544@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> 
> Afaics, this problem was resolved a long ago.
> 
> The patch below should fix this problem. Does it?

Forgot to mention, this patch was tested,

Steven Pratt wrote:
>
> This is the patch I think we should apply.  Running tiobench with 4k 
> request size, 4GB working set, 256 threads and a 2MB max_readahead (to 
> help induce thrashing) on a 1GB 8way machine, throughput of sequential 
> IO increased from 50MB/sec to 92MB/sec on a 5disk raid0 array.  Tests 
> with smaller max_readaheads and smaller thread counts were all withing 
> the noise range of the benchmark, which is to be expected.

Oleg.
