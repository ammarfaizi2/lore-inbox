Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281663AbRLGOdc>; Fri, 7 Dec 2001 09:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281678AbRLGOdX>; Fri, 7 Dec 2001 09:33:23 -0500
Received: from dsl-213-023-043-071.arcor-ip.net ([213.23.43.71]:38152 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S281663AbRLGOdG>;
	Fri, 7 Dec 2001 09:33:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Date: Fri, 7 Dec 2001 15:35:55 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
        ramon@thebsh.namesys.com, yura@namesys.com
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <E16CCn9-0000sC-00@starship.berlin> <3C10B7C7.6030602@namesys.com>
In-Reply-To: <3C10B7C7.6030602@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16CM6V-0000t3-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 7, 2001 01:36 pm, Hans Reiser wrote:
http://innominate.org/~graichen/projects/lxr/source/include/linux/reiserfs_fs.h?v=v2.4#L1393 
> >
> >  1393 create a new node.  We implement S1 balancing for the leaf nodes
> >  1394 and S0 balancing for the internal nodes (S1 and S0 are defined in
> >  1395 our papers.)*/
>
> How about I just explain it instead?  We preserve a criterion of nodes 
> must be 50% full for internal nodes and criterion of no 3 nodes can be 
> squeezed into 2 nodes for leaf nodes.
> 
> A tree that satisfies the criterion that no N nodes can be squeezed into 
> N-1 nodes is an SN tree.  I don't remember where Konstantin Shvachko 
> published his paper on this, maybe it can be found.

<nit> Then shouldn't that be "S3 balancing for the leaf nodes and S2 
balancing for the internal nodes"?

--
Daniel
