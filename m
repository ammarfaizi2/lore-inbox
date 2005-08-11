Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbVHKFk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbVHKFk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 01:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVHKFk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 01:40:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750877AbVHKFkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 01:40:55 -0400
Date: Wed, 10 Aug 2005 22:40:45 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: zach@vmware.com, akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org,
       hpa@zytor.com, Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org
Subject: Re: [PATCH 8/14] i386 / Add a per cpu gdt accessor
Message-ID: <20050811054045.GU7762@shell0.pdx.osdl.net>
References: <200508110456.j7B4ue56019587@zach-dev.vmware.com> <Pine.LNX.4.61.0508102344060.16483@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508102344060.16483@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zwane Mwaikambo (zwane@arm.linux.org.uk) wrote:
> On Wed, 10 Aug 2005 zach@vmware.com wrote:
> 
> > Add an accessor function for getting the per-CPU gdt.  Callee must already
> > have the CPU.
> 
> This one seems superfluous to me, does accessing it indirectly generate 
> better code too?

It's prepratory for other work.

thanks,
-chris
