Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbTIWQCj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 12:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbTIWQCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 12:02:38 -0400
Received: from havoc.gtf.org ([63.247.75.124]:13500 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261630AbTIWQCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 12:02:37 -0400
Date: Tue, 23 Sep 2003 12:02:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Christoph Hellwig <hch@dolly1.pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] drivers/Kconfig
Message-ID: <20030923160236.GA20000@gtf.org>
References: <20030923152032.GA16599@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923152032.GA16599@lst.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 05:20:32PM +0200, Christoph Hellwig wrote:
> What do people think about creating a common drivers/Kconfig
> that includes the drivers/*/Kconfig files?  This saves quite
> a few superflous Kconfig lines and is a natural way to avoid
> the architectyures going out of sync.  Yes, this requires
> every driver having proper bus-depencies but we should be
> almost there already.
> 
> Sample patch (for ppc, i386 and x86_64) attached.  

Yes, this is the goal.

This won't be very useful to the more exotic architectures like S/390,
which use almost none of drivers/* except for drivers/s390/*, so for
non-PCI, non-ISA architectures I have a feeling that including
drivers/Kconfig would be a waste.

	Jeff




