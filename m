Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267532AbUBSUKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267541AbUBSUKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:10:45 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:4110 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S267532AbUBSUKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:10:41 -0500
Date: Thu, 19 Feb 2004 05:04:43 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       arjanv@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       torvalds@osdl.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-ID: <20040219130442.GJ1269@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040218140021.GB1269@us.ibm.com> <20040218211035.A13866@infradead.org> <20040218150607.GE1269@us.ibm.com> <20040218222138.A14585@infradead.org> <20040218145132.460214b5.akpm@osdl.org> <20040218230055.A14889@infradead.org> <20040218153234.3956af3a.akpm@osdl.org> <20040219123237.B22406@infradead.org> <20040219105608.30d2c51e.akpm@osdl.org> <20040219190141.A26888@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219190141.A26888@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 07:01:41PM +0000, Christoph Hellwig wrote:
> On Thu, Feb 19, 2004 at 10:56:08AM -0800, Andrew Morton wrote:
> > inter-node cache consistency.  Other distributed filesystems will need this
> > and probably AIX already provides it.
> 
> You've probably not seen the AIX VM architecture.  Good for you as it's
> not good for your stomache.  I did when I still was SCAldera and although
> my NDAs don't allow me to go into details I can tell you that the AIX
> VM architecture is deeply tied into the segment architecture of the Power
> CPU and signicicantly different from any other UNIX variant.
> 
> So porting code from AIX that touches anything VM related is a complete
> rewrite.

Or, alternatively, requires a surprisingly large glue-code layer.

							Thanx, Paul
