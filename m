Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267408AbUBSBmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 20:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267410AbUBSBmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 20:42:15 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:16043 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S267408AbUBSBmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 20:42:11 -0500
Date: Wed, 18 Feb 2004 10:36:05 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, arjanv@redhat.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-ID: <20040218183605.GG1269@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040217124001.GA1267@us.ibm.com> <20040217161929.7e6b2a61.akpm@osdl.org> <1077108694.4479.4.camel@laptop.fenrus.com> <20040218140021.GB1269@us.ibm.com> <20040218211035.A13866@infradead.org> <20040218150607.GE1269@us.ibm.com> <20040218222138.A14585@infradead.org> <20040218145132.460214b5.akpm@osdl.org> <20040218230055.A14889@infradead.org> <20040218162858.2a230401.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218162858.2a230401.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 04:28:58PM -0800, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Yes.  Andrew, please read the GPL, it's very clear about derived works.
> > Then please tell me why you think gpfs is not a derived work.
> 
> OK, so I looked at the wrapper.  It wasn't a tremendously pleasant
> experience.  It is huge, and uses fairly standard-looking filesytem
> interfaces and locking primitives.  Also some awareness of NFSV4 for some
> reason.
>
> Still, the wrapper is GPL so this is not relevant.  Its only use is to tell
> us whether or not the non-GPL bits are "derived" from Linux, and it
> doesn't do that.

In the spirit of full disclosure, the wrapper is actually
distributed under the BSD license.  The GPFS guys tell
me that the "gpl" in the RPM name means "GPFS Portability
Layer".

					Thanx, Paul
