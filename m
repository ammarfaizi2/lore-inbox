Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWGHAmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWGHAmJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWGHAmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:42:08 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:30933 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932462AbWGHAmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:42:07 -0400
Date: Fri, 7 Jul 2006 17:41:53 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Bligh <mbligh@google.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [RFC 4/8] page allocator: Optional ZONE_DMA
In-Reply-To: <200607080223.01380.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0607071741330.4352@schroedinger.engr.sgi.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
 <20060708000522.3829.85832.sendpatchset@schroedinger.engr.sgi.com>
 <200607080223.01380.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2006, Andi Kleen wrote:

> I think your idea of saving some cache lines by not having the unused
> zones in the fallback lists etc. is a good one, but your current implementation
> with its ifdef maze is extremly ugly. Surely this can be a done less
> intrusively?

I'd be glad if someone would come up with such an idea.

