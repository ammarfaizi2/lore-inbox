Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVBHT6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVBHT6I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 14:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVBHT6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 14:58:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:53985 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261647AbVBHT6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 14:58:04 -0500
Date: Tue, 8 Feb 2005 11:54:25 -0800
From: Greg KH <greg@kroah.com>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compile error: 2.6.10 / megaraid_mbox
Message-ID: <20050208195425.GB24698@kroah.com>
References: <20050208081057.GC21154@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208081057.GC21154@schottelius.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 09:10:57AM +0100, Nico Schottelius wrote:
> Good morning!
> 
> I was trying to compile Megaraid on 2.6.10 and
> noticed that pci_dma_sync_single and pci_dma_sync_sg
> are deprecated. Greg seems to tried to patch it in 2.6.9
> (http://lkml.org/lkml/2004/10/19/425), but it seems he didn't catch it
> all.
> 
> A patch against vanialla 2.6.10 is attached.

Hm, can you redo the patch so that I can apply it with "-p1" to patch,
and add a Signed-off-by: line (also keep the same description as above.)

thanks,

greg k-h
