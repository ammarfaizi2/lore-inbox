Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266549AbUGUToO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266549AbUGUToO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 15:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266565AbUGUToO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 15:44:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:58299 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266549AbUGUToM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 15:44:12 -0400
Date: Wed, 21 Jul 2004 14:25:35 -0400
From: Greg KH <greg@kroah.com>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] delete devfs
Message-ID: <20040721182535.GC16838@kroah.com>
References: <20040721141524.GA12564@kroah.com> <E1BnIHx-0003Py-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BnIHx-0003Py-00@chiark.greenend.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 03:41:45PM +0100, Matthew Garrett wrote:
> Greg KH <greg@kroah.com> wrote:
> 
> >Ok, to test out the new development model, here's a nice patch that
> >simply removes the devfs code.  No commercial distro supports this for
> >2.6, and both Gentoo and Debian have full udev support for 2.6, so it is
> >not needed there either.  Combine this with the fact that Richard has
> >sent me a number of good udev patches to fix up some "emulate devfs with
> >udev" minor issues, I think we can successfully do this now.
> 
> The new Debian installer requires devfs on several architectures, even
> for 2.6 installs. That's unlikely to get changed before release.

Great, if you want to rely on this, and you get around to using a kernel
that doesn't have it in it, just add it to the other patches you apply
to your kernel.

thanks,

greg k-h
