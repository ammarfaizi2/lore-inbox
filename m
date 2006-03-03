Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752188AbWCCIRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbWCCIRB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 03:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbWCCIRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 03:17:01 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:29056 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752187AbWCCIRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 03:17:00 -0500
Date: Fri, 3 Mar 2006 00:16:54 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Andi Kleen <ak@suse.de>
Cc: Michael Monnerie <m.monnerie@zmi.at>, linux-kernel@vger.kernel.org,
       suse-linux-e@suse.com
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Message-ID: <20060303081654.GA11559@taniwha.stupidest.org>
References: <200603020023.21916@zmi.at> <200603020203.49128.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603020203.49128.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 02:03:48AM +0100, Andi Kleen wrote:

> Nvidia hardware SATA cannot directly DMA to > 4GB, so it has to go
> through the IOMMU.

do you know if that is an actual hardware limitation or simply a
something we don't know how to do for lack of docs?

> And in that kernel the Nforce ethernet driver also didn't do >4GB
> access, although the ethernet HW is theoretically capable.

hrm, again, with a lack of docs is that likely to occur anytime soon?
