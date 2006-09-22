Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWIVSlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWIVSlU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWIVSlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:41:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49348 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964882AbWIVSlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:41:19 -0400
Date: Fri, 22 Sep 2006 11:40:59 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Jesse Barnes <jesse.barnes@intel.com>
cc: Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Rohit Seth <rohitseth@google.com>
Subject: Re: ZONE_DMA
In-Reply-To: <200609221139.03250.jesse.barnes@intel.com>
Message-ID: <Pine.LNX.4.64.0609221139570.8356@schroedinger.engr.sgi.com>
References: <20060920135438.d7dd362b.akpm@osdl.org> <200609221126.31201.jesse.barnes@intel.com>
 <Pine.LNX.4.64.0609221129170.8356@schroedinger.engr.sgi.com>
 <200609221139.03250.jesse.barnes@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006, Jesse Barnes wrote:

> Right, the internals are arch specific and don't necessarily have to rely 
> on a zone, depending on their DMA constraints.

>From what I can see the arch specific do some tricks and then pick GFP_DMA 
or something to get memory that is appropriately limited. Having the 
ability to retrieve pages from a certain range from the page allocator 
would fix this issue and improve the ability of devices to allocate 
memory.

