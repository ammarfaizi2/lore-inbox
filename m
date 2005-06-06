Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVFFLnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVFFLnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 07:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVFFLns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 07:43:48 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:5900 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261276AbVFFLnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 07:43:46 -0400
Date: Mon, 6 Jun 2005 13:43:42 +0200
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: Easy trick to reduce kernel footprint
Message-ID: <20050606114342.GA15757@alpha.home.local>
References: <20050605223528.GA13726@alpha.home.local> <20050606010246.GA22252@animx.eu.org> <20050606041101.GA14799@alpha.home.local> <20050606110743.GA23107@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050606110743.GA23107@animx.eu.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 07:07:43AM -0400, Wakko Warner wrote:
 
> My initramfs is passed via initrd so that I can change any aspect of it with
> out recompiling the kernel (or maybe i could use a better understanding of
> initramfs)  I compared bzImage to bupxImage and the savings I got was around
> 50kb difference IIRC.

With what algo and what kernel size ?
With the close-source upx-1.93 linked with the NRV compression, I often
observe an average 15-20% gain on the bzImage size if it does not embed
an initramfs. I remember that the UCL library was not as good as the NRV,
so I've stopped using it a long time ago.

Regards,
Willy

