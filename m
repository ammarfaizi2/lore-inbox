Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVCRUU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVCRUU4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 15:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVCRUU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 15:20:56 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:17594 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261268AbVCRUUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 15:20:51 -0500
Date: Fri, 18 Mar 2005 12:19:50 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@muc.de>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher
 order
In-Reply-To: <20050318192808.GB38053@muc.de>
Message-ID: <Pine.LNX.4.58.0503181217530.17596@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
 <200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com>
 <200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com>
 <20050318192808.GB38053@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005, Andi Kleen wrote:

> It does not make any sense if you think of it - the memory bus
> of the CPU cannot be that much faster than the cache.

The memory bus would be able to reach a higher rate if properly optimized
for sequential writes to memory. A cache typically does random writes.
