Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265969AbUFJCDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265969AbUFJCDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 22:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266100AbUFJCDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 22:03:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14818 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265969AbUFJCDd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 22:03:33 -0400
Date: Thu, 10 Jun 2004 03:03:32 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: faith@valinux.com, dri-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.6.7-rc3 drivers/char/drm/gamma_dma.c: several user/kernel pointer bugs
Message-ID: <20040610020332.GC12308@parcelfarce.linux.theplanet.co.uk>
References: <1086821620.32053.120.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086821620.32053.120.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 03:53:40PM -0700, Robert T. Johnson wrote:
> gamma_dma_priority and gamma_dma_send_buffers both deref d->send_indices
> and/or d->send_sizes.  When these functions are called from gamma_dma, 
> these pointers are user pointers and are thus not safe to deref.  This patch
> copies over the pointers inside gamma_dma_priority and 
> gamma_dma_send_buffers.  Let me know if you have any questions or if I've 
> made a mistake.

ACK.
