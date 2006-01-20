Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161161AbWATBMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbWATBMO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 20:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWATBMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 20:12:14 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:46722
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030374AbWATBMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 20:12:13 -0500
Date: Thu, 19 Jan 2006 17:11:32 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: thomas@winischhofer.net, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/misc/sisusbvga/: possible cleanups
Message-ID: <20060120011132.GA28981@kroah.com>
References: <20060119011854.GV19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119011854.GV19398@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 02:18:54AM +0100, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly global functions static
> - function and struct declarations belong into header files
> - make SiS_VCLKData const
> - #if 0 the following unused global functions:
>   - sisusb.c: sisusb_writew()
>   - sisusb.c: sisusb_readw()
>   - sisusb_init.c: SiSUSB_GetModeID()
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

For some reason, this doesn't apply.  Care to rediff it?

thanks,

greg k-h
