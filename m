Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVHKSow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVHKSow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVHKSov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:44:51 -0400
Received: from ns2.suse.de ([195.135.220.15]:6573 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932355AbVHKSov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:44:51 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NCQ support NVidia NForce4 (CK804) SATAII
References: <DBFABB80F7FD3143A911F9E6CFD477B004FAE3E7@hqemmail02.nvidia.com.suse.lists.linux.kernel>
	<20050811070943.GB8025@vega.lgb.hu.suse.lists.linux.kernel>
	<1123765523.32375.10.camel@mindpipe.suse.lists.linux.kernel>
	<42FB6C27.1010408@gmail.com.suse.lists.linux.kernel>
	<42FB88F8.7040807@pobox.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 11 Aug 2005 20:44:49 +0200
In-Reply-To: <42FB88F8.7040807@pobox.com.suse.lists.linux.kernel>
Message-ID: <p734q9w48ke.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> Michael Thonke wrote:
> > There is no other way to use a nearly good chipset for AMD64 cpus.
> > Via's chipsets are really buggy not acceptable, so what else ULi/Ali
> > who cares where to buy?
> 
> 
> What specifically does not work, on VIA+AMD64 combination, under Linux?

The only known problem is the broken IOMMU, but unless you have >3GB
of memory and plan to use highspeed devices that can only address 4GB
that should not make muc difference.

-Andi
