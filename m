Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267233AbUBSMcm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 07:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267231AbUBSMcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 07:32:42 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:30483 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267229AbUBSMck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 07:32:40 -0500
Date: Thu, 19 Feb 2004 12:32:37 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, paulmck@us.ibm.com,
       arjanv@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       torvalds@osdl.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-ID: <20040219123237.B22406@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, paulmck@us.ibm.com,
	arjanv@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	torvalds@osdl.org
References: <20040217124001.GA1267@us.ibm.com> <20040217161929.7e6b2a61.akpm@osdl.org> <1077108694.4479.4.camel@laptop.fenrus.com> <20040218140021.GB1269@us.ibm.com> <20040218211035.A13866@infradead.org> <20040218150607.GE1269@us.ibm.com> <20040218222138.A14585@infradead.org> <20040218145132.460214b5.akpm@osdl.org> <20040218230055.A14889@infradead.org> <20040218153234.3956af3a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040218153234.3956af3a.akpm@osdl.org>; from akpm@osdl.org on Wed, Feb 18, 2004 at 03:32:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 03:32:34PM -0800, Andrew Morton wrote:
> > Yes.  We've traditionally not exported symbols unless we had an intree user,
> > and especially not if it's for a module that's not GPL licensed.
> 
> That's certainly a good rule of thumb and we (and I) have used it before.
> 
> What is the reasoning behind it?

The reason is that someone who wants to distribute a binary only module
has to show it's module is not a derived work, and someone who needs new
core in the kernel and new exports pretty much shows his work is deeply
integrated with the kernel.

