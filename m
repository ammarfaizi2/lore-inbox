Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbSJQQVq>; Thu, 17 Oct 2002 12:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261555AbSJQQVq>; Thu, 17 Oct 2002 12:21:46 -0400
Received: from ns.suse.de ([213.95.15.193]:58373 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261550AbSJQQVn>;
	Thu, 17 Oct 2002 12:21:43 -0400
Date: Thu, 17 Oct 2002 18:27:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre11aa1
Message-ID: <20021017182739.J20761@oldwotan.suse.de>
References: <15355.1034859667@ocs3.intra.ocs.com.au> <200210180126.37013.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210180126.37013.harisri@bigpond.com>; from harisri@bigpond.com on Fri, Oct 18, 2002 at 01:26:36AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 01:26:36AM +1000, Srihari Vijayaraghavan wrote:
> Hello Keith,
> 
> > You don't need that, just mkdir /var/log/ksymoops.  modprobe/insmod
> > will create a daily log file and snapshot a copy of lsmod and
> > /proc/ksyms for every module loaded or unloaded.  All with sync in the
> > right places.
> 
> Thanks, and that works fine.

if you enabled it before getting the new oopses what's interesting is
that you send me a tarball of /var/log/ksymoops, so I
will also be able to resolve those module addresses too (please send me
also your agpgart.o and your radeon.o modules, all from the same
kernels: .o, ksymoops and below oopses).

thanks,

Andrea
