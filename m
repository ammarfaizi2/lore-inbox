Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWFPUF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWFPUF1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 16:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWFPUF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 16:05:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51631 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751496AbWFPUF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 16:05:26 -0400
Date: Fri, 16 Jun 2006 13:05:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: christoph@lameter.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 2/2] slab: consolidate allocation paths
In-Reply-To: <1150355565.4633.8.camel@ubuntu>
Message-ID: <Pine.LNX.4.64.0606161304400.16488@schroedinger.engr.sgi.com>
References: <1150355565.4633.8.camel@ubuntu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2006, Pekka Enberg wrote:

> This patch consolidates the UMA and NUMA memory allocation paths in the
> slab allocator. This is accomplished by making the UMA-path look like
> we are on NUMA but always allocating from the current node.

Which kernel does this apply to? Cannot find this in upstream nor in 
Andrews tree.

