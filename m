Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWGHAXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWGHAXs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWGHAXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:23:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:63173 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932440AbWGHAX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:23:28 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC 5/8] x86_64 without ZONE_DMA
Date: Sat, 8 Jul 2006 02:20:39 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Martin Bligh <mbligh@google.com>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com> <20060708000527.3829.58852.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060708000527.3829.58852.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607080220.39100.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 July 2006 02:05, Christoph Lameter wrote:
> x86_64: ZONE_DMA/ZONE_DMA32 optional
> 
> Allow the use to specify CONFIG_ZONE_DMA32 and CONFIG_ZONE_DMA (via
> CONFIG_GENERIC_ISA_DMA).

Why? 

I don't think the savings from this are enough to bother
the user with such an obscure config option.

-Andi

