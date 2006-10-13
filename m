Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWJMWA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWJMWA6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 18:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWJMWA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 18:00:58 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:14801 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932076AbWJMWA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 18:00:57 -0400
Date: Fri, 13 Oct 2006 15:01:34 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: Will Schmidt <will_schmidt@vnet.ibm.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
Message-ID: <20061013220134.GB4974@monkey.ibm.com>
References: <1160764895.11239.14.camel@farscape> <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com> <1160769226.11239.22.camel@farscape> <1160773040.11239.28.camel@farscape> <20061013212202.GG28620@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061013212202.GG28620@localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 04:22:02PM -0500, Nathan Lynch wrote:
> Will Schmidt wrote:
> > NUMA associativity depth for CPU/Memory: 3
> > adding cpu 0 to node 0
> > node 0
> > NODE_DATA() = c000000015ffee80
> > start_paddr = 8000000
> > end_paddr = 16000000
> > bootmap_paddr = 15ffc000
> > reserve_bootmem ffc0000 40000
> > reserve_bootmem 15ffc000 2000
> > reserve_bootmem 15ffee80 1180
> > node 1
> > NODE_DATA() = c000000021ff7c80
> > start_paddr = 0
> > end_paddr = 22000000
> 
> Strange, node 0 appears to be in the middle of node 1.

IIRC, this is fairly common.  Or, it was on the system/LPAR I had access
to.  I'd check again, but I lost easy access to that system. :(

-- 
Mike
