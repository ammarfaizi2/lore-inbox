Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422672AbWGJP5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbWGJP5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWGJP5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:57:08 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:37792 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422672AbWGJP5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:57:07 -0400
Date: Mon, 10 Jul 2006 08:56:50 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: linux-kernel@vger.kernel.org, mbligh@google.com, hch@infradead.org,
       marcelo@kvack.org, arjan@infradead.org, nickpiggin@yahoo.com.au,
       ak@suse.de
Subject: Re: [RFC 1/8] Add CONFIG_ZONE_DMA to all archesM
In-Reply-To: <20060710095254.bad0084b.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0607100855580.4491@schroedinger.engr.sgi.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
 <20060708000506.3829.34340.sendpatchset@schroedinger.engr.sgi.com>
 <20060710095254.bad0084b.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006, KAMEZAWA Hiroyuki wrote:

> 
> How about configuring this by
> 
> config ZONE_DMA
> 	def_bool y
> 	depends on GENERIC_ISA_DMA || ARCH_ZONE_DMA
> 
> and set ARCH_ZONE_DMA for each arch ?

Yes we do something like that in a later patch. What would be the 
advantage of having CONFIG_ARCH_ZONE_DMA instead of CONFIG_ZONE_DMA?


