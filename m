Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWCVT3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWCVT3J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 14:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWCVT3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 14:29:08 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:20610 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932418AbWCVT3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 14:29:07 -0500
Date: Wed, 22 Mar 2006 11:29:24 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Zachary Amsden <zach@vmware.com>, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>
Subject: Re: [Xen-devel] [RFC PATCH 14/35] subarch modify CPU capabilities
Message-ID: <20060322192924.GC15997@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063751.151430000@sorel.sous-sol.org> <44210C4B.7050307@vmware.com> <b996c814fbd26c1521380aed1fdd4a56@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b996c814fbd26c1521380aed1fdd4a56@cl.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Keir Fraser (Keir.Fraser@cl.cam.ac.uk) wrote:
> 
> On 22 Mar 2006, at 08:35, Zachary Amsden wrote:
> 
> >That's pretty heinous.  Suppose Xen decides to start supporting any of 
> >these features.  Now, you need to change all of the Xen modified 
> >kernels to remove pieces of this.
> 
> Well, old kernels would still work and most of those features aren't 
> all that useful in a virtualised environment anyway. But, point taken, 
> adding a hypervisor trap for CPUID and making use of it would clean up 
> that code.

Agreed, added to todo.

thanks,
-chris
