Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbUCCTEp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 14:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbUCCTEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 14:04:44 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:8188 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262544AbUCCTEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 14:04:43 -0500
Date: Wed, 3 Mar 2004 11:04:05 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, Dave McCracken <dmccr@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <20040303190405.GA5190@w-mikek2.beaverton.ibm.com>
References: <20040303070933.GB4922@dualathlon.random> <20040303025820.2cf6078a.akpm@osdl.org> <7440000.1078328791@[10.10.2.4]> <7710000.1078329523@[10.1.1.4]> <20040303160802.A30084@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303160802.A30084@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 04:08:02PM +0000, Christoph Hellwig wrote:
> On Wed, Mar 03, 2004 at 09:58:44AM -0600, Dave McCracken wrote:
> > It'd mean the page struct would have to have a count of the number of
> > mlock()ed regions it belongs to, and we'd have to update all the pages each
> > time we call it.
> 
> That would add another atomic_t to struct pages..
> 
> But if we did it it would help some xfs fixes I'm doing currently a whole lot
> 

As someone looking into hotplug memory, I can imagine this also helping
out in that area.

-- 
Mike
