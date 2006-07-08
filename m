Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWGHBAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWGHBAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 21:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWGHBAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 21:00:24 -0400
Received: from cantor2.suse.de ([195.135.220.15]:43209 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932475AbWGHBAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 21:00:23 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC 5/8] x86_64 without ZONE_DMA
Date: Sat, 8 Jul 2006 03:00:16 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Martin Bligh <mbligh@google.com>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com> <200607080220.39100.ak@suse.de> <Pine.LNX.4.64.0607071742060.4352@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0607071742060.4352@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607080300.16931.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 July 2006 02:42, Christoph Lameter wrote:
> On Sat, 8 Jul 2006, Andi Kleen wrote:
> 
> > I don't think the savings from this are enough to bother
> > the user with such an obscure config option.
> 
> The savings are not only from the code paths. The VM itself is cleaner and 
> the balancing issues are not that troublesome anymore.

Doesn't help - it has to be fixed anyways for NUMA and other architectures.

Also in my experience empty zones are not a significant problem for VM
balancing.

-Andi
