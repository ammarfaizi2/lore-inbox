Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbUCDO5r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 09:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbUCDO5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 09:57:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31465 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261921AbUCDO5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 09:57:44 -0500
Date: Wed, 3 Mar 2004 18:34:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Timothy Miller <miller@techsource.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, richard.brunner@amd.com,
       linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD64
Message-ID: <20040303173411.GC531@openzaurus.ucw.cz>
References: <7F740D512C7C1046AB53446D37200173EA28A5@scsmsx402.sc.intel.com> <403E4681.20603@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403E4681.20603@techsource.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Yes, "implementation specific" is one of the differences between 
> >IA-32e
> >and AMD64, i.e. that behavior is architecturally defined on AMD64, 
> >but
> >on IA-32e (as I posted): 
> >  Near branch with 66H prefix:
> >    As documented in PRM the behavior is implementation specific and
> >should 
> >    avoid using 66H prefix on near branches.
> 
> 
> In other words, Intel's implementation deviates from the architecture 
> as defined by AMD.  So it's not 100% compatible.  I just want this 
> point to be clear.
> 
> 
> If these sorts of branches are common enough (and I suspect they 
> are), then this sort of deviation could have a notable code-size (and 

They are not.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

