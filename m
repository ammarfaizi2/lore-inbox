Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262044AbSJDPXs>; Fri, 4 Oct 2002 11:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262046AbSJDPXs>; Fri, 4 Oct 2002 11:23:48 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:9747 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262044AbSJDPWr>; Fri, 4 Oct 2002 11:22:47 -0400
Date: Fri, 4 Oct 2002 16:28:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: Re: export of sys_call_table
Message-ID: <20021004162818.A2670@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20021003153943.E22418@openss7.org> <20021004145845.A30064@infradead.org> <20021004091517.H18191@openss7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021004091517.H18191@openss7.org>; from bidulock@openss7.org on Fri, Oct 04, 2002 at 09:15:17AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 09:15:17AM -0600, Brian F. G. Bidulock wrote:
> Christoph,
> 
> On Fri, 04 Oct 2002, Christoph Hellwig wrote:
> > 
> > There is no such thing as iBCS for 2.4+.  iBCS/Linux-ABI are for foreign
> > personalities only anyway and don't need to touch sys_call_table.
> > 
> 
> iBCS is right there in arch/sparc64/solaris/socksys.c, timod.c, systbl.S

No that's not iBCS.  Even if some code is derivaed it's ceratainly something
different.
