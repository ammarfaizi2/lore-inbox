Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267596AbUHPMoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267596AbUHPMoT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 08:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267597AbUHPMoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 08:44:19 -0400
Received: from linux.us.dell.com ([143.166.224.162]:15596 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S267596AbUHPMoE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 08:44:04 -0400
Date: Mon, 16 Aug 2004 07:43:54 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Sylvain COUTANT <sylvain.coutant@illicom.com>
Cc: "'Tom Sightler'" <ttsig@tuxyturvy.com>,
       "'Linux-Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: High CPU usage (up to server hang) under heavy I/O load
Message-ID: <20040816124354.GA3786@lists.us.dell.com>
References: <1092454748.3816.11.camel@localhost.localdomain> <20040815203153.3EB913074E@illicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815203153.3EB913074E@illicom.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 10:30:57PM +0200, Sylvain COUTANT wrote:
> > What driver are you using for the PERC?
> 
> Megaraid "2". As far as I know, in newer kernels, this is the only one
> compiled in. We have had several problems with the previous one. Also, Matt
> Domsch's page state the exact versions you need depending on your system.
> 
> Our 1750's work very well using RAID PERC4/DI under 2.4.26's megaraid
> driver. Although they are not really stressed ...
> 
> > I've been wanting to try the 'megaraid2' driver
> 
> Hopefully, Matt will send his advice on the subject, but I think you should
> try this asap.

All PERC4-series adapters should really use 'megaraid2' in 2.4.x, and
as far as we know, megaraid2 handles all previous LSI-based adapters
just fine too.  In 2.6.x, there is only one driver 'megaraid', which
is the megaraid2 code base - no need for an older driver there.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
