Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268310AbUI3Iko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268310AbUI3Iko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 04:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268317AbUI3Iko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 04:40:44 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:56774 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S268310AbUI3Ikl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 04:40:41 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 30 Sep 2004 10:23:05 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Christoph Hellwig <hch@infradead.org>, Hanna Linder <hannal@us.ibm.com>,
       linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       greg@kroah.com
Subject: Re: [PATCH 2.6.9-rc2-mm4 bttv-driver.c][4/8] convert pci_find_device to pci_dev_present
Message-ID: <20040930082305.GB20456@bytesex>
References: <15470000.1096491322@w-hlinder.beaverton.ibm.com> <20040929220344.A17872@infradead.org> <20040929222353.GF21770@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040929222353.GF21770@thundrix.ch>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 12:23:53AM +0200, Tonnerre wrote:
> Salut,
> 
> On Wed, Sep 29, 2004 at 10:03:44PM +0100, Christoph Hellwig wrote:
> > I think this check should just go away completely.  
> > We don't have such silly warnings in any other driver.
> 
> Kraxel introduced this  check because of the confusion  with the "old"
> and "new" WinTV cards. The older one had a bt848 chip, the newer one a
> connexant 878, and only the older one was supported by Linux.

Yep, that was the reason.  It's pretty much obsolete these days through
as we have a working (well, sort of, depending on the tv norm sound may
be a problem ...) driver for these cards in mainline.  Just dropping
that now is perfectly fine.

  Gerd

-- 
return -ENOSIG;
