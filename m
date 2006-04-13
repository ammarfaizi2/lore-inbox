Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWDMUxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWDMUxI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 16:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWDMUxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 16:53:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:31647 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932463AbWDMUxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 16:53:06 -0400
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to
	1GB, V2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Olof Johansson <olof@lixom.net>, paulus@samba.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060413173121.GJ10412@granada.merseine.nu>
References: <20060413020559.GC24769@pb15.lixom.net>
	 <20060413022809.GD24769@pb15.lixom.net>
	 <20060413025233.GE24769@pb15.lixom.net>
	 <20060413064027.GH10412@granada.merseine.nu>
	 <1144925149.4935.14.camel@localhost.localdomain>
	 <20060413160712.GG24769@pb15.lixom.net>
	 <20060413173121.GJ10412@granada.merseine.nu>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 06:52:44 +1000
Message-Id: <1144961564.4935.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 20:31 +0300, Muli Ben-Yehuda wrote:
> On Thu, Apr 13, 2006 at 11:07:12AM -0500, Olof Johansson wrote:
> 
> > Walking the DT means we need to hardcode it on PCI IDs, since the Apple
> > OF doesn't give the Airport device a logical name. It's probably easier
> > to implement than walking PCI, but we'd need to maintain a table. My
> > vote is for PCI walking, I'll give that a shot over the weekend.
> 
> Cool! bonus points if you do it in drivers/pci and we can steal it
> easily for Calgary on x8-64 :-)

How so ? Anything remotely related to the iommu is totally different...
Besides, on x86-64, laptops _are_ more common, and thus the problem of
cardbus cards is much more significant.

Ben.


