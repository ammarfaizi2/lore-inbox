Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263331AbTCNNm1>; Fri, 14 Mar 2003 08:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263332AbTCNNm1>; Fri, 14 Mar 2003 08:42:27 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:20294 "EHLO
	dhcp64-226.boston.redhat.com") by vger.kernel.org with ESMTP
	id <S263331AbTCNNmZ>; Fri, 14 Mar 2003 08:42:25 -0500
Date: Fri, 14 Mar 2003 08:53:09 -0500 (EST)
From: Rik van Riel <riel@surriel.com>
X-X-Sender: riel@dhcp64-226.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre5aa1
In-Reply-To: <20030314090825.GB1375@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0303140852220.27094-100000@dhcp64-226.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003, Andrea Arcangeli wrote:

> Only in 2.4.21pre4aa3: 9900_aio-17.gz
> Only in 2.4.21pre5aa1: 9900_aio-18.gz
> 
> 	Cleaned up the whole asm/kmap_types.h mess, moved
> 	kmap_types.h into linux/, this must be visible
> 	for aio and it has to be the same for all archs so it doesn't belong to
> 	asm/.

Maybe I'm dense, maybe it's early on a friday morning, maybe
even both ... but I don't understand why architectures without
highmem should have kmap_types.h

