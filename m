Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268085AbUHFPRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268085AbUHFPRz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUHFPRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:17:55 -0400
Received: from colin2.muc.de ([193.149.48.15]:33546 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268085AbUHFPQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:16:26 -0400
Date: 6 Aug 2004 17:16:25 +0200
Date: Fri, 6 Aug 2004 17:16:25 +0200
From: Andi Kleen <ak@muc.de>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, suparna@in.ibm.com, shemminger@osdl.org,
       vamsi_krishna@in.ibm.com
Subject: Re: [0/3]kprobes-base-268-rc3.patch
Message-ID: <20040806151625.GA96991@muc.de>
References: <2pMzT-XA-21@gated-at.bofh.it> <m3hdrhyhuy.fsf@averell.firstfloor.org> <20040806123757.GB3376@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806123757.GB3376@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 06:07:57PM +0530, Prasanna S Panchamukhi wrote:
> Hi Andi,
> 
> Please find the exception notifiers patch for i386 architecture ported from 
> x86_64 architecture.
> Also I would like to mention that:
> 
> Earlier Stephen Hemminger ported notifiers to i386. The reason to drop the patch was
> was, there were some bad interaction issues with using the hooks for NMI (trap
> 2), locking and oprofile. 
> 
> Please review and provide your comments.

The register_i386... names look ugly.  Leave the i386 out.

Other than that it looks ok.

Thanks,

Is it good enough for kprobes?

-Andi

