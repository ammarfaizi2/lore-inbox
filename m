Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVDLHNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVDLHNh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 03:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVDLHML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 03:12:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39843 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262042AbVDLHGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 03:06:46 -0400
Date: Tue, 12 Apr 2005 09:06:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.12-rc2-mm3
Message-ID: <20050412070638.GA7161@suse.de>
References: <20050411012532.58593bc1.akpm@osdl.org> <20050411220013.23416d5f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411220013.23416d5f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11 2005, Andrew Morton wrote:
> - CFQ is seriously, seriously read-starved on this workload.
> 
> CFQ3:
> 
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  1  5   1008  25888   4204 3845820    0    0    12 50544 1119   116  0  3 49 48
>  0  5   1008  24096   4204 3847520    0    0     8 51200 1112   110  0  3 49 48
>  0  5   1008  25824   4204 3845820    0    0     8 54816 1117   120  0  4 49 48
>  0  5   1008  25440   4204 3846160    0    0     8 52880 1113   115  0  3 49 48
>  0  5   1008  25888   4208 3845748    0    0    16 51024 1121   116  0  3 49 48

Looks very bad, I'll have a look at this.

-- 
Jens Axboe

