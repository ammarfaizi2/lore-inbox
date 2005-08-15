Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbVHOSJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVHOSJg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbVHOSJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:09:35 -0400
Received: from pop.gmx.de ([213.165.64.20]:62692 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964880AbVHOSJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:09:21 -0400
X-Authenticated: #20450766
Date: Mon, 15 Aug 2005 20:07:52 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] scsi bug fixes for 2.6.13
In-Reply-To: <Pine.LNX.4.60.0508150811580.5302@poirot.grange>
Message-ID: <Pine.LNX.4.60.0508152006180.6593@poirot.grange>
References: <1123184634.5026.58.camel@mulgrave>  <Pine.LNX.4.60.0508142121000.4594@poirot.grange>
 <1124048890.18802.13.camel@mulgrave> <Pine.LNX.4.60.0508150811580.5302@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2005, Guennadi Liakhovetski wrote:

> On Sun, 14 Aug 2005, James Bottomley wrote:
> 
> > OK, why don't we do this.  Instead of having me trawl through the trees
> > looking for the correct patch to reverse, why don't you attach it in an
> > email and I'll try to get it in to 2.6.13?
> 
> Looks like just reverting that patch is not enough. More in about 12 
> hours.

Sorry, forget it, just tested here with (pseudo-)highmem on SMP . just 
reverting the patch does indeed fix the driver.

Thanks
Guennadi
---
Guennadi Liakhovetski
