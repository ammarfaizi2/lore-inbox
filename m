Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267953AbUHEV3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267953AbUHEV3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267949AbUHEV12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:27:28 -0400
Received: from the-village.bc.nu ([81.2.110.252]:5567 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267972AbUHEV0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:26:49 -0400
Subject: Re: 2.6.8-rc3-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040805174233.A1506@infradead.org>
References: <20040805031918.08790a82.akpm@osdl.org>
	 <20040805174233.A1506@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091737446.8366.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 Aug 2004 21:24:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-05 at 17:42, Christoph Hellwig wrote:
> > +iteraid.patch
> > +iteraid-cleanup.patch
> > 
> >  New ITE IT8212 RAID controller driver.  Still needs a bit of work before
> >  handoff to the scsi guys to look at.
> 
> Just drop it.  It's not scsi hardware at all, and we have an ide driver for
> that hardware already.

We have a very test IDE driver. Probably what we ideally need is a
driver using bits of both using Jeff's new ATA/SATA layer.

