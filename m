Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVCIRfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVCIRfX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 12:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVCIRfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 12:35:23 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:7842 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262123AbVCIReM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 12:34:12 -0500
Date: Wed, 9 Mar 2005 12:33:44 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Support for GEODE CPUs
Message-ID: <20050309173344.GD17865@csclub.uwaterloo.ca>
References: <200503081935.j28JZ433020124@hera.kernel.org> <1110387668.28860.205.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110387668.28860.205.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 05:01:09PM +0000, Alan Cox wrote:
[snip]
> And I have each time pointed out it is wrong over time because
> 
> a) "Geode" (Geode GX) runs -m486 code faster than -m586
> b) "Geode" as a name also includes AMD Athlon "Geode NX" processors
> c) Geode GX does not need OOSTORE because the processor manages DMA
> snooping in hardware.

It even looks to me like the Geode GX1 (SCx200 family) is a Cyrix MediaGX
design, the Geode GX2 (Geode GX 533@1.1W and company) I suspect is an
AMD k6 based design (given the 400Mhz speed, and the inclusion of 3Dnow
and MMX), and of course the Geode NX is athlon based.

Now if the Geode GX1 in fact runs faster optimized for 486 rather than
586 (I have been running one as 586tsc since it had mmx and tsc in its
feature list), then I think I will be recompiling my kernel to see if I
can't make this 266MHz GX1 run almost as fast as a 400MHz PXA255 (arm).
Right now it has somewhat lower ethernet bandwidth than the arm.

Len Sorensen
