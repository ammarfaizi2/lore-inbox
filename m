Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVEBRTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVEBRTp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 13:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVEBRT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 13:19:27 -0400
Received: from colin.muc.de ([193.149.48.1]:13061 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261315AbVEBRQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 13:16:54 -0400
Date: 2 May 2005 19:16:53 +0200
Date: Mon, 2 May 2005 19:16:53 +0200
From: Andi Kleen <ak@muc.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] {,un}register_ioctl32_conversion should have been removed last month
Message-ID: <20050502171653.GH27150@muc.de>
References: <20050502014550.GG3592@stusta.de> <20050502160916.GE27150@muc.de> <20050502163429.GM3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502163429.GM3592@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 06:34:29PM +0200, Adrian Bunk wrote:
> On Mon, May 02, 2005 at 06:09:16PM +0200, Andi Kleen wrote:
> > On Mon, May 02, 2005 at 03:45:51AM +0200, Adrian Bunk wrote:
> > > This removal should have happened last month.
> > 
> > Thanks. I believe I2O and s390 are still using it though. The I2O patch
> > is pending somewhere and s390 will hopefully catch up. 
> 
> There are no users in 2.6.12-rc3-mm2.

Great. It can go then.

BTW with that the BKL in compat_ioctl can be removed too - it is useless
now.

-Andi
