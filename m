Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWC3W1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWC3W1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 17:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWC3W1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 17:27:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7834 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750757AbWC3W1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 17:27:20 -0500
Date: Thu, 30 Mar 2006 14:27:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Airlie <airlied@linux.ie>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [git pull] DRM changes for 2.6.17
In-Reply-To: <Pine.LNX.4.64.0603302255530.6981@skynet.skynet.ie>
Message-ID: <Pine.LNX.4.64.0603301427020.27203@g5.osdl.org>
References: <Pine.LNX.4.64.0603300650180.24125@skynet.skynet.ie>
 <Pine.LNX.4.64.0603301232050.27203@g5.osdl.org> <Pine.LNX.4.64.0603302255530.6981@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Mar 2006, Dave Airlie wrote:
> 
> No it means people with old X versions won't try to enable hw accel on cards
> that their X.org doesn't suppport...
> 
> The X.org drivers with respect to r300 drivers are highly experimental and
> enabled DRI on r300 by default before they should, when I added the r300 PCI
> IDs as I tried last time, lots of people crashed and you backed out the
> changes... so now the kernel isn't going to to trigger those problems, as all
> of the new r300 class cards require using a new Xorg driver to enable DRI..
> 
> Its the only way I can think off to get the r300 PCI ids into the kernel and
> not break current systems... there is nothing I can do in the DRM to fix the
> Xorg DDX stupidity..

Ok, thanks. Sounds good. Pulled,

		Linus
