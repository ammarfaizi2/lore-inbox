Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268796AbUHLVKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268796AbUHLVKC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268793AbUHLVJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:09:36 -0400
Received: from havoc.gtf.org ([216.162.42.101]:5046 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S268796AbUHLVGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:06:01 -0400
Date: Thu, 12 Aug 2004 17:03:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Clem Taylor <clemtaylor@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Any news on a higher performance sata_sil SIL_QUIRK_MOD15WRITE workaround?
Message-ID: <20040812210345.GA9558@havoc.gtf.org>
References: <411AFD2C.5060701@comcast.net> <411B118B.4040802@pobox.com> <1092312030.21994.25.camel@localhost.localdomain> <411B89EA.3040400@pobox.com> <1092340739.22362.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092340739.22362.16.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 08:59:00PM +0100, Alan Cox wrote:
> On Iau, 2004-08-12 at 16:16, Jeff Garzik wrote:
> > > It fixes it completely on the drivers/ide driver.
> > 
> > SATA bus traces say otherwise.
> 
> Do you issue 15 or less or just combinations that are ok. With the 
> siimage driver I just use the 15 limit and after hammering it hard
> couldn't get it to fall over, while trying to be clever it did fall
> over.

hmmm, perhaps I misunderstood your email?

'15 or less' limit works, but 'sectors % 15 == 1' still produces odd
Data FIS sizes that confuse Seagate drives.

I thought you were saying that 'sectors % 15 == 1' was OK.

	Jeff



