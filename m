Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422819AbWA1Dug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422819AbWA1Dug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 22:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422826AbWA1Dug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 22:50:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10422 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422819AbWA1Duf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 22:50:35 -0500
Date: Fri, 27 Jan 2006 19:49:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org,
       jmforbes@linuxtx.org, zwane@arm.linux.org.uk, tytso@mit.edu,
       rdunlap@xenotime.net, davej@redhat.com, chuckw@quantumlinux.com,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 09/12] Mask off GFP flags before swiotlb_alloc_coherent
Message-Id: <20060127194954.0c9efcd6.akpm@osdl.org>
In-Reply-To: <200601280333.25026.ak@suse.de>
References: <20060128020629.908825000@press.kroah.org>
	<20060128022121.GJ17001@kroah.com>
	<200601280333.25026.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
>  On Saturday 28 January 2006 03:21, Greg KH wrote:
>  > 2.6.15.2 -stable review patch.  If anyone has any objections, please let 
>  > us know.
> 
>  That patch isn't in mainline yet and shouldn't be merged to stable before
>  that happens.

But this patch will never go into mainline - pci-gart.c was radically
altered in 2.6.16-rc1.


