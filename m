Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135380AbRDRVtT>; Wed, 18 Apr 2001 17:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135382AbRDRVtK>; Wed, 18 Apr 2001 17:49:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:29168 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135380AbRDRVs4>;
	Wed, 18 Apr 2001 17:48:56 -0400
Date: Wed, 18 Apr 2001 17:48:50 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jeff Golds <jgolds@resilience.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc_lookup not exported
In-Reply-To: <3ADDC2BB.47C7DF0C@resilience.com>
Message-ID: <Pine.GSO.4.21.0104181747460.15153-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Apr 2001, Jeff Golds wrote:

> I don't see why not. I created my own mkdir and rmdir handlers in my
> module.  I'd like to use the lookup function that proc supplies instead
> of supplying my own, why shouldn't I be allowed to do that?  It's not as
> if I am doing something other than what normally happens:  I am
> assigning inode_operations::lookup to be proc_lookup.

Use ramfs as a model; procfs is not well-suited for that sort of work.

