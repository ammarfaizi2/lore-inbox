Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVHKGAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVHKGAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 02:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVHKGAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 02:00:19 -0400
Received: from fsmlabs.com ([168.103.115.128]:10450 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S964796AbVHKGAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 02:00:18 -0400
Date: Thu, 11 Aug 2005 00:06:13 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Zachary Amsden <zach@vmware.com>
cc: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org
Subject: Re: [PATCH 8/14] i386 / Add a per cpu gdt accessor
In-Reply-To: <42FAE7E7.1000502@vmware.com>
Message-ID: <Pine.LNX.4.61.0508110004010.16483@montezuma.fsmlabs.com>
References: <200508110456.j7B4ue56019587@zach-dev.vmware.com>
 <Pine.LNX.4.61.0508102344060.16483@montezuma.fsmlabs.com> <42FAE7E7.1000502@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005, Zachary Amsden wrote:

> Thanks for the feedback.  I believe the binary compilation is the same.  It is
> superfluous in the sense that there is not yet a real use for it, but it is
> needed for later developement.
> 
> Xen requires page isolation of system data structures that could be used to
> override privilege.  Since they do not shadow the GDT, they require the GDT to
> be write protected.  A side effect of that is that the GDT must be moved to an
> isolated page.  Thus, the accessors to allow transparently moving the GDT for
> a paravirtual build.  There is deliberately no effect on the standard build.

Thanks for the explanation, i wasn't quite sure what you were planning on 
doing with the gdt table there.

> P.S. Sorry I got your mail address wrong earlier.  I mistyped it from the
> update to the CREDITS patch.

Not a problem, i actually had to double check to make sure i didn't spell 
it incorrectly too ;)

