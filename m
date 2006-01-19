Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161178AbWASC6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161178AbWASC6a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 21:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160999AbWASC6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 21:58:30 -0500
Received: from mail.kroah.org ([69.55.234.183]:10426 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161177AbWASC63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 21:58:29 -0500
Date: Wed, 18 Jan 2006 18:54:26 -0800
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: RFC: ipath ioctls and their replacements
Message-ID: <20060119025426.GB15706@kroah.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com> <20060119005316.GA26884@kroah.com> <1137633441.4757.228.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137633441.4757.228.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 05:17:20PM -0800, Bryan O'Sullivan wrote:
> On Wed, 2006-01-18 at 16:53 -0800, Greg KH wrote:
> 
> > Use the firmware subsystem for this.  It uses sysfs so ioctl needed at
> > all.
> 
> OK.  Would I be correct in thinking that drivers/firmware/dcdbas.c is a
> reasonable model implementation to follow?

No.  Pick a driver that has a backing device, like the wireless drivers
that use it.  That Dell bios driver has had more looney extensions than
I can shake a stick at...

thanks,

greg k-h
