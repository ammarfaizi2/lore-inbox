Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbUD1TuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUD1TuB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUD1Tt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:49:58 -0400
Received: from colin2.muc.de ([193.149.48.15]:49423 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264992AbUD1RUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 13:20:24 -0400
Date: 28 Apr 2004 19:20:23 +0200
Date: Wed, 28 Apr 2004 19:20:23 +0200
From: Andi Kleen <ak@muc.de>
To: Zoltan.Menyhart@bull.net
Cc: lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>
Subject: Re: sched_domains and Stream benchmark
Message-ID: <20040428172023.GA38574@colin2.muc.de>
References: <1N7xQ-7fh-29@gated-at.bofh.it> <m3r7uitr1r.fsf@averell.firstfloor.org> <1083018633.3070.8.camel@farah> <408F7DBB.1BC60BB7@nospam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408F7DBB.1BC60BB7@nospam.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 11:47:39AM +0200, Zoltan Menyhart wrote:
> > Darren Hart <dvhltc@us.ibm.com> writes:
> > 
> > [...]
> > 
> > I didn't actually compile them myself; someone sent me executables
> > compiled with the PGI compiler.  Maybe your compiler has a different
> > runtime and behaves differently? 
> > 
> > You can find them and my test script that tests everything in 
> > ftp://ftp.suse.com/pub/people/ak/bench/stream.tar.gz
> 
> Is this benchmark available for other machines, e.g. for IA-64 ?
> Can I have a copy for IA-64, please ?

http://www.cs.virginia.edu/stream/

Compile the OpenMP C or Fortran version with a OpenMP capable compiler 
and run it parallel on each CPU.

Exact results may also vary with the OpenMP runtime.

-Andi
