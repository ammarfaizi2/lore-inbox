Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbVHKFzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVHKFzF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 01:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbVHKFzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 01:55:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964784AbVHKFzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 01:55:02 -0400
Date: Wed, 10 Aug 2005 22:54:53 -0700
From: Chris Wright <chrisw@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Chris Wright <chrisw@osdl.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       zach@vmware.com, akpm@osdl.org, chrisl@vmware.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org
Subject: Re: [PATCH 8/14] i386 / Add a per cpu gdt accessor
Message-ID: <20050811055453.GV7762@shell0.pdx.osdl.net>
References: <200508110456.j7B4ue56019587@zach-dev.vmware.com> <Pine.LNX.4.61.0508102344060.16483@montezuma.fsmlabs.com> <20050811054045.GU7762@shell0.pdx.osdl.net> <42FAE59F.8070009@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FAE59F.8070009@zytor.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Peter Anvin (hpa@zytor.com) wrote:
> Chris Wright wrote:
> >* Zwane Mwaikambo (zwane@arm.linux.org.uk) wrote:
> >>On Wed, 10 Aug 2005 zach@vmware.com wrote:
> >>>Add an accessor function for getting the per-CPU gdt.  Callee must 
> >>>already
> >>>have the CPU.
> >>
> >>This one seems superfluous to me, does accessing it indirectly generate 
> >>better code too?
> >
> >It's prepratory for other work.
> 
> I am assuming it has no change on the code, right?  (If it does, 
> something is wrong...)

That's correct, should be no change.

thanks,
-chris
