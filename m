Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUBSA3U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 19:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267194AbUBSA3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 19:29:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:7343 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267197AbUBSA1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 19:27:23 -0500
Date: Wed, 18 Feb 2004 16:28:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: hch@infradead.org, paulmck@us.ibm.com, arjanv@redhat.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-Id: <20040218162858.2a230401.akpm@osdl.org>
In-Reply-To: <20040218230055.A14889@infradead.org>
References: <20040216190927.GA2969@us.ibm.com>
	<20040217073522.A25921@infradead.org>
	<20040217124001.GA1267@us.ibm.com>
	<20040217161929.7e6b2a61.akpm@osdl.org>
	<1077108694.4479.4.camel@laptop.fenrus.com>
	<20040218140021.GB1269@us.ibm.com>
	<20040218211035.A13866@infradead.org>
	<20040218150607.GE1269@us.ibm.com>
	<20040218222138.A14585@infradead.org>
	<20040218145132.460214b5.akpm@osdl.org>
	<20040218230055.A14889@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> Yes.  Andrew, please read the GPL, it's very clear about derived works.
> Then please tell me why you think gpfs is not a derived work.

OK, so I looked at the wrapper.  It wasn't a tremendously pleasant
experience.  It is huge, and uses fairly standard-looking filesytem
interfaces and locking primitives.  Also some awareness of NFSV4 for some
reason.

Still, the wrapper is GPL so this is not relevant.  Its only use is to tell
us whether or not the non-GPL bits are "derived" from Linux, and it
doesn't do that.

The GPL doesn't define a derived work.  It says

  "If identifiable sections of that work are not derived from the
   Program, and can be reasonably considered independent and separate works
   in themselves, then this License, and its terms, do not apply to those
   sections when you distribute them as separate works.  But when you
   distribute the same sections as part of a whole which is a work based on
   the Program, the distribution of the whole must be on the terms of this
   License, ..."

And the "But when you distribute..." part is what the Linus doctrine rubs
out.  Because it is unreasonable to say that a large piece of work such as
this is "derived" from Linux.

Why do you believe that GPFS represents a kernel licensing violation?
