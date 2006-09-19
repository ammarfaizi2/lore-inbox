Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWISPSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWISPSK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 11:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWISPSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 11:18:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:667 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750735AbWISPSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 11:18:08 -0400
Date: Tue, 19 Sep 2006 07:21:16 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-mm1
Message-ID: <20060919142116.GA29190@kroah.com>
References: <20060919012848.4482666d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060919012848.4482666d.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 01:28:48AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc7/2.6.18-rc7-mm1/
> 
> 
> - git-input.patch has been dropped due to major mismatches between it
>   and the driver tree.
> 
> - git-alsa.patch has been dropped due to similar mismatches.
> 
> - ia64 doesn't build due to bugs in the PCI tree.
> 
> - The kernel doesn't work properly on RH FC3 or pretty much anything
>   which uses old udev, due to improvements in the driver tree.

I've reworked the driver tree, so all 4 of these issues should no longer
happen.

Although the ia64 one should not be due to anything in the driver tree,
I don't know what caused that, the pci tree is pretty tiny right now.

Sorry for the mess.

greg k-h
