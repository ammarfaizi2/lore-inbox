Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263167AbSITR73>; Fri, 20 Sep 2002 13:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263170AbSITR73>; Fri, 20 Sep 2002 13:59:29 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:45710 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263167AbSITR73>; Fri, 20 Sep 2002 13:59:29 -0400
Date: Fri, 20 Sep 2002 11:05:32 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: Dave Hansen <haveblue@us.ibm.com>, "Bond, Andrew" <Andrew.Bond@hp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: TPC-C benchmark used standard RH kernel
Message-ID: <20020920180532.GC1944@beaverton.ibm.com>
References: <45B36A38D959B44CB032DA427A6E106402D09E43@cceexc18.americas.cpqcorp.net> <3D8A3654.50201@us.ibm.com> <20020920172041.GB1944@beaverton.ibm.com> <20020920173103.GK936@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920173103.GK936@suse.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe [axboe@suse.de] wrote:
> On Fri, Sep 20 2002, Mike Anderson wrote:
> 
> They benched RHAS iirc, and that has the block-highmem patch. They also
> had more than 4GB of memory, alas, there is bouncing. That doesn't work
> on all hardware, and all drivers.

Yes I have seen that. Normally a lot of these greater that 4GB
interfaces are activated on BITS_PER_LONG. We have passed a few changes
on to adapter driver maintainers to activate these interfaces also on
the CONFIG_HIGHMEM64G. This has helped on these 32 bit greater than 4GB
systems.

What driver does the FCA 2214 use?

-andmike
-- 
Michael Anderson
andmike@us.ibm.com

