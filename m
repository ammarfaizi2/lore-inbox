Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264910AbUGMLyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbUGMLyF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 07:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbUGMLyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 07:54:05 -0400
Received: from styx.suse.cz ([82.119.242.94]:46487 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264910AbUGMLyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 07:54:02 -0400
Date: Tue, 13 Jul 2004 13:55:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrew Morton <akpm@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Update pcips2 driver
Message-ID: <20040713115547.GB31206@ucw.cz>
References: <20040712154207.A15469@flint.arm.linux.org.uk> <20040712132525.550bcebb.akpm@osdl.org> <20040712225550.B15469@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712225550.B15469@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 10:55:50PM +0100, Russell King wrote:
> On Mon, Jul 12, 2004 at 01:25:25PM -0700, Andrew Morton wrote:
> > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > >
> > > Use pci_request_regions()/pci_release_regions() instead of
> > > request_region()/release_region()
> > 
> > Some of this patch is already in Vojtech's tree.  If it's not critical,
> > perhaps it would be best if he took the remaining bit:
> 
> Looking at the bits in the 2.6.7-mm7 tree, none of my original patch
> is merged, and merging the bit below would mean that we then have an
> asymetry between the function used to request the resources and the
> function used to release them.
> 
> Therefore, I think the original patch should stand as-is.
 
I don't seem to have the bigger patch in my mailbox. Can you resend it?
Thanks.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
