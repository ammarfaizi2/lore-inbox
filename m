Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVHRRYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVHRRYw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 13:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbVHRRYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 13:24:52 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:35784 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932320AbVHRRYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 13:24:52 -0400
Date: Thu, 18 Aug 2005 10:20:59 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
cc: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: idle task's task_t allocation on NUMA machines
In-Reply-To: <20050818153932.GH8123@implementation.labri.fr>
Message-ID: <Pine.LNX.4.62.0508181019240.26282@schroedinger.engr.sgi.com>
References: <20050818140829.GB8123@implementation.labri.fr>
 <4304A6DF.6040703@cosmosbay.com> <20050818153932.GH8123@implementation.labri.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005, Samuel Thibault wrote:

> Indeed, but I guess there are a lot of such little optimizations here
> and there that could be relatively easily fixed, for a not-so little
> benefit.

Get on it :-) I hope the kmalloc_node stuff etc that was recently added is 
enough for most structur4es. Note that there is a new rev of the slab 
allocator in Andrew's tree that will make kmalloc_node as fast as kmalloc.

