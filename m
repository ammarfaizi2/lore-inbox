Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423103AbWJRW3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423103AbWJRW3l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 18:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423102AbWJRW3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 18:29:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:14757 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1423100AbWJRW3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 18:29:40 -0400
Date: Wed, 18 Oct 2006 14:34:51 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MSI messages in 2.6.19-rc2
Message-ID: <20061018213451.GC5206@kroah.com>
References: <20061016133005.08d20b18@freekitty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061016133005.08d20b18@freekitty>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 01:30:05PM -0700, Stephen Hemminger wrote:
> Got this on boot up, doesn't seem to be reliably reproducible.
> System ran okay. My guess is it is a mulithread probe issue
> 
> [    2.773198] assign_interrupt_mode Found MSI capability
> [    2.773227] assign_interrupt_mode Found MSI capability
> [    2.773291] kmem_cache_create: duplicate cache msi_cache

Yes it is :(

I'll make up a patch to fix this, thanks for letting me know.

greg k-h
