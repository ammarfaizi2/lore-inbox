Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbUASXY2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 18:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUASXY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 18:24:28 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:32851 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263595AbUASXY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:24:27 -0500
Date: Mon, 19 Jan 2004 16:45:35 -0600
From: Jack Steiner <steiner@SGI.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jes Sorensen <jes@trained-monkey.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jbarnes@SGI.com, torvalds@osdl.org
Subject: Re: [patch] increse MAX_NR_MEMBLKS to same as MAX_NUMNODES on NUMA
Message-ID: <20040119224535.GA12728@sgi.com>
References: <E1AiZ5h-00043I-00@jaguar.mkp.net> <4990000.1074542883@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4990000.1074542883@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 12:08:04PM -0800, Martin J. Bligh wrote:
> > Since we now support # of CPUs > BITS_PER_LONG with cpumask_t it would
> > be nice to be able to support more than BITS_PER_LONG memory blocks.
> 
> Nothing uses them. We're probably better off just removing them altogether.

I dont understand.
node_memblk[] is used on IA64 in arch/ia64/mm/discontig.c (& other places too).


-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


