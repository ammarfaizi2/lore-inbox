Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbULQAAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbULQAAA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 19:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbULPX77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:59:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:48349 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262208AbULPX7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:59:50 -0500
Date: Thu, 16 Dec 2004 15:56:34 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: scottm@somanetworks.com, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/pci/hotplug/ : simply use MODULE
Message-ID: <20041216235634.GC11424@kroah.com>
References: <20041211165459.GV22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041211165459.GV22324@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2004 at 05:54:59PM +0100, Adrian Bunk wrote:
> The patch below lets five files under drivers/pci/hotplug/ simply use 
> MODULE to check whether they are compiled as part of a module.
> 
> MODULE is the common idiom for checking whether a file is built as part 
> of a module.
> 
> In theory, my patch shouldn't have made any difference, but if you look 
> closely, the previous #if's in cpcihp_generic.c and cpci_hotplug_pci.c 
> weren't correct.

Applied, thanks.

greg k-h
