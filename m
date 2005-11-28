Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVK1VAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVK1VAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 16:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbVK1VAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 16:00:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:17108 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751253AbVK1VAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 16:00:10 -0500
Date: Mon, 28 Nov 2005 12:52:20 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: gregkh@suse.de, Thomas Winischhofer <thomas@winischhofer.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/misc/sisusbvga/sisusb.c: remove dead code
Message-ID: <20051128205220.GE17740@kroah.com>
References: <20051120232239.GI16060@stusta.de> <20051123190237.GA28080@kroah.com> <20051123203150.GT3963@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123203150.GT3963@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 09:31:50PM +0100, Adrian Bunk wrote:
> On Wed, Nov 23, 2005 at 11:02:37AM -0800, Greg KH wrote:
> > On Mon, Nov 21, 2005 at 12:22:39AM +0100, Adrian Bunk wrote:
> > > The Coverity checker found this obviously dead code.
> > 
> > I think the checker is wrong, this does not look correct to me.
> 
> Why?
> 
> Due to the while(length), length can't be 0 at the switch.

Doh, ok, nevermind.  Care to resend this?

thanks,

greg k-h
