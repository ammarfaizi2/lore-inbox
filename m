Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319055AbSHFKqW>; Tue, 6 Aug 2002 06:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319056AbSHFKqW>; Tue, 6 Aug 2002 06:46:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:15013 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319055AbSHFKqU>;
	Tue, 6 Aug 2002 06:46:20 -0400
Date: Tue, 6 Aug 2002 16:29:47 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       vamsi_krishna@in.ibm.com
Subject: Re: [PATCH] kprobes for 2.5.30
Message-ID: <20020806162947.A22164@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <Pine.LNX.4.44.0208052247380.1171-100000@home.transmeta.com> <20020806073804.690DE4BA4@lists.samba.org> <20020806085918.A13396@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020806085918.A13396@infradead.org>; from hch@infradead.org on Tue, Aug 06, 2002 at 08:59:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 08:59:18AM +0100, Christoph Hellwig wrote:
> On Tue, Aug 06, 2002 at 05:22:15PM +1000, Rusty Russell wrote:
> > Vamsi, what do you think of this patch?  Is it neccessary to restore
> > interrupts before handle_vm86_trap (the original patch didn't do this
> > either, not sure if it's required).
> 
> Any chance you could split the i386-specific kprobes code into
> arch/i386/kernel/kprobes.c instead of bloating traps.c?

Agreed. Please see the latest patch.

-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
