Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWDMP5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWDMP5j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 11:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWDMP5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 11:57:39 -0400
Received: from lixom.net ([66.141.50.11]:63394 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1751016AbWDMP5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 11:57:38 -0400
Date: Thu, 13 Apr 2006 10:57:17 -0500
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB, V2
Message-ID: <20060413155717.GF24769@pb15.lixom.net>
References: <20060413020559.GC24769@pb15.lixom.net> <20060413022809.GD24769@pb15.lixom.net> <20060413025233.GE24769@pb15.lixom.net> <20060413064027.GH10412@granada.merseine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413064027.GH10412@granada.merseine.nu>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 09:40:27AM +0300, Muli Ben-Yehuda wrote:
> On Wed, Apr 12, 2006 at 09:52:33PM -0500, Olof Johansson wrote:
> 
> > iommu=off can still be used for those who don't want to deal with the
> > overhead (and don't need it for any devices).
> 
> I've been pondering walking the PCI bus before deciding to enable an
> IOMMU and checking each device's DMA mask. Is this something that you
> considered and rejected, or just something no one got around to doing?

It's something I thought about, but right now we enable the IOMMU quite
early during boot. It'd take a bit of surgery to shuffle things, and I
decided that it's not worth the work (and risk of regressions) for 2.6.17.



-Olof
