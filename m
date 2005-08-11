Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVHKOKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVHKOKI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVHKOKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:10:07 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:60378 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1750765AbVHKOKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:10:06 -0400
Date: Fri, 12 Aug 2005 00:10:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Michael Kerrisk" <mtk-lkml@gmx.net>
Cc: trond.myklebust@fys.uio.no, peterc@gelato.unsw.edu.au,
       linux-kernel@vger.kernel.org, matthew@wil.cx, michael.kerrisk@gmx.net
Subject: Re: fcntl(F GETLEASE) semantics??
Message-Id: <20050812001004.68779bfc.sfr@canb.auug.org.au>
In-Reply-To: <994.1123766559@www9.gmx.net>
References: <1123764552.8251.43.camel@lade.trondhjem.org>
	<994.1123766559@www9.gmx.net>
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2005 15:22:39 +0200 (MEST) "Michael Kerrisk" <mtk-lkml@gmx.net> wrote:
>
> > A shared (i.e. read) lease means that there are currently no processes
> > that can change the data or metadata (including your own). 
>                                         ^^^^^^^^^^^^^^^^^
> 
> This is precisely the point of the problem.  Stephen 
> Rothwell, and Matthew Wilcox seem to be saying that
> the last bit is not the case.  

Sorry, Michael, I was not aware of why the change was made and I must
defer to Trond (for NFSv4) and the CIFS team on the appropriate semantics
here.  Matthew may have another opinion.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
