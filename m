Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVECOsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVECOsj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVECOs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:48:27 -0400
Received: from colin.muc.de ([193.149.48.1]:29956 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261618AbVECOqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:46:53 -0400
Date: 3 May 2005 16:46:52 +0200
Date: Tue, 3 May 2005 16:46:52 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, hch@lst.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] {,un}register_ioctl32_conversion should have been removed last month
Message-ID: <20050503144652.GB76815@muc.de>
References: <20050502014550.GG3592@stusta.de> <20050502173052.5c78ae30.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502173052.5c78ae30.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 05:30:52PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > This removal should have happened last month.
> 
> drivers/usb/misc/sisusbvga/sisusb.c will use these functions if someone
> defines SISUSB_OLD_CONFIG_COMPAT, so we need to agree to zap that code
> before I can merge this upstream.

I had a patch to fix that one. I think I sent it to the maintainer,
perhaps he ignored it. I will dig it up again.

-Andi
