Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264986AbSLBUVe>; Mon, 2 Dec 2002 15:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264990AbSLBUVe>; Mon, 2 Dec 2002 15:21:34 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:27561 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264986AbSLBUVd>; Mon, 2 Dec 2002 15:21:33 -0500
Date: Mon, 2 Dec 2002 15:32:03 -0500
From: Doug Ledford <dledford@redhat.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Lee Leahu <lee@ricis.com>, linux-kernel@vger.kernel.org
Subject: Re: vmware + aic7xxx + 2.4.19-4gb-smp = kernel panic
Message-ID: <20021202203203.GC20362@redhat.com>
Mail-Followup-To: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	Lee Leahu <lee@ricis.com>, linux-kernel@vger.kernel.org
References: <8BB282713D2@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8BB282713D2@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 08:19:50PM +0100, Petr Vandrovec wrote:
> Not that aic7xxx driver should panic due to that, but...

I've sent a note under separate cover to Justin about this particular 
panic.  I've seen it once before and I relayed some more details to him.  
For example, on my machine, I was using the stock Red Hat kernels.  The 
i386 BOOT kernel worked fine, the i686 kernel panic'ed just like this.  
You might try recompiling the kernel as an i386 kernel without a bunch of 
optimizations and see if that changes things.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
