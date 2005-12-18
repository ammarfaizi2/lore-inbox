Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965276AbVLRVZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965276AbVLRVZd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 16:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965278AbVLRVZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 16:25:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:58774 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965276AbVLRVZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 16:25:32 -0500
Date: Sun, 18 Dec 2005 12:51:46 -0800
From: Greg KH <greg@kroah.com>
To: Sebastian Kaergel <mailing@wodkahexe.de>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] Re: Linux 2.6.14.4 [intelfb problem]
Message-ID: <20051218205146.GA16453@kroah.com>
References: <20051215005041.GB4148@kroah.com> <20051218204253.b32a4f61.mailing@wodkahexe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051218204253.b32a4f61.mailing@wodkahexe.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 08:42:53PM +0100, Sebastian Kaergel wrote:
> Hi,
> 
> after installing 2.6.14.4 I'm no longer able to use my intelfb-console.
> 
> .config is exactly the same as with 2.6.14.3, but 2.6.14.4 doesn't
> switch to fb at all. Just the normal console appears.
> 
> dmesg output:
> <snip>
> intelfb: Video mode must be programmed at boot time.
> <snip>
> 
> lilo.conf:
> vga=791
> image=/boot/2.6.14.4-3
>  append="video=intelfb"
> 
> I don't know, why it isn't working, since nothing intelfb or fb related
> changed in this release.

Any chance you can try applying the different patches that were posted
to lkml to 2.6.14.3 and see which one causes the problem?

thanks,

greg k-h
