Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbULCJX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbULCJX4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 04:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbULCJX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 04:23:56 -0500
Received: from mail.suse.de ([195.135.220.2]:39611 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262106AbULCJXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 04:23:55 -0500
Date: Fri, 3 Dec 2004 10:23:52 +0100
From: Andi Kleen <ak@suse.de>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc2-mm4
Message-ID: <20041203092352.GD25528@wotan.suse.de>
References: <20041130095045.090de5ea.akpm@osdl.org> <1101865072.20437.4.camel@arrakis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101865072.20437.4.camel@arrakis>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 05:37:53PM -0800, Matthew Dobson wrote:
> On Tue, 2004-11-30 at 09:50, Andrew Morton wrote:
> > +x86_64-experimental-4gb-dma-zone.patch
> > 
> >  Add a fourth memory zone on x86_64: ZONE_DMA32
> 
> Andi,
> 	I think you made a small mistake in this patch.  There should be no
> need to modify ZONES_SHIFT or MAX_ZONES_SHIFT for the change you wish to
> make, since 4 zones (0..3) still fit into 2 bits.

Right yes. Thanks.

-Andi
