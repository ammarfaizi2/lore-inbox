Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267316AbUBSTCw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267298AbUBSTCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:02:52 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:25863 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267486AbUBSTCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:02:08 -0500
Date: Thu, 19 Feb 2004 19:01:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, paulmck@us.ibm.com,
       arjanv@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       torvalds@osdl.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-ID: <20040219190141.A26888@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, paulmck@us.ibm.com,
	arjanv@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	torvalds@osdl.org
References: <1077108694.4479.4.camel@laptop.fenrus.com> <20040218140021.GB1269@us.ibm.com> <20040218211035.A13866@infradead.org> <20040218150607.GE1269@us.ibm.com> <20040218222138.A14585@infradead.org> <20040218145132.460214b5.akpm@osdl.org> <20040218230055.A14889@infradead.org> <20040218153234.3956af3a.akpm@osdl.org> <20040219123237.B22406@infradead.org> <20040219105608.30d2c51e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040219105608.30d2c51e.akpm@osdl.org>; from akpm@osdl.org on Thu, Feb 19, 2004 at 10:56:08AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 10:56:08AM -0800, Andrew Morton wrote:
> inter-node cache consistency.  Other distributed filesystems will need this
> and probably AIX already provides it.

You've probably not seen the AIX VM architecture.  Good for you as it's
not good for your stomache.  I did when I still was SCAldera and although
my NDAs don't allow me to go into details I can tell you that the AIX
VM architecture is deeply tied into the segment architecture of the Power
CPU and signicicantly different from any other UNIX variant.

So porting code from AIX that touches anything VM related is a complete
rewrite.

Nice argumentation though, for everything but AIX it might actually have
worked :)

