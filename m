Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261536AbTCKRVE>; Tue, 11 Mar 2003 12:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261538AbTCKRVE>; Tue, 11 Mar 2003 12:21:04 -0500
Received: from dp.samba.org ([66.70.73.150]:17550 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261536AbTCKRVE>;
	Tue, 11 Mar 2003 12:21:04 -0500
Date: Wed, 12 Mar 2003 04:29:34 +1100
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@muc.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dcache hash distrubition patches
Message-ID: <20030311172934.GB8268@krispykreme>
References: <10280000.1047318333@[10.10.2.4]> <20030310175221.GA20060@averell> <26350000.1047368465@[10.10.2.4]> <20030311152322.GA2358@averell> <31840000.1047396682@[10.10.2.4]> <20030311162734.GA5640@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030311162734.GA5640@averell>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I doubt inode cache is very critical, except perhaps in NFS server loads
> (but even the nfs server has an own frontend cache)
> Normally the dcache should bear most of the load.

I did some analysis of the hashes ages ago. From memory the regular
grouping of inodes caused this unbalanced distribution:

http://samba.org/~anton/linux/hashes/1/icache.png

Anton
