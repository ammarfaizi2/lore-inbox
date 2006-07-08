Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWGHAnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWGHAnG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWGHAnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:43:06 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:31429 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932463AbWGHAnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:43:05 -0400
Date: Fri, 7 Jul 2006 17:42:53 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, Martin Bligh <mbligh@google.com>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [RFC 5/8] x86_64 without ZONE_DMA
In-Reply-To: <200607080220.39100.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0607071742060.4352@schroedinger.engr.sgi.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
 <20060708000527.3829.58852.sendpatchset@schroedinger.engr.sgi.com>
 <200607080220.39100.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2006, Andi Kleen wrote:

> I don't think the savings from this are enough to bother
> the user with such an obscure config option.

The savings are not only from the code paths. The VM itself is cleaner and 
the balancing issues are not that troublesome anymore.
