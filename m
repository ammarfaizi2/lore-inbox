Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318115AbSHSIBl>; Mon, 19 Aug 2002 04:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318163AbSHSIBl>; Mon, 19 Aug 2002 04:01:41 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:48645 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318115AbSHSIBl>; Mon, 19 Aug 2002 04:01:41 -0400
Date: Mon, 19 Aug 2002 09:05:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31 : include/asm-generic/a.out.h
Message-ID: <20020819090543.A17985@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208182101270.861-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208182101270.861-100000@localhost.localdomain>; from fdavis@si.rr.com on Sun, Aug 18, 2002 at 09:20:52PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 09:20:52PM -0400, Frank Davis wrote:
> Hello all,
>   The following patch creates a new file, include/asm-generic/a.out.h , 
> that attempts to consolidate 'struct exec' within the individual 
> include/asm/a.out.h files without creating a #ifdef mess. Arch diffs for cris, i386, mips, and 
> ppc are included. Please review. 

As sparc is pretty different I'd suggest leaving it out of the generic
one (that why we still support per-arch ones!). 

And I think you can just kill the cris one - that arch _never_ supported a.ou
binaries..  The same is true for a big number of other architectures.
