Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVFFUhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVFFUhX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVFFUhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:37:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:15029 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261672AbVFFUfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 16:35:43 -0400
Date: Mon, 6 Jun 2005 13:35:29 -0700
From: Greg KH <greg@kroah.com>
To: Abhay_Salunke@Dell.com
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt_Domsch@Dell.com
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Message-ID: <20050606203528.GA9205@kroah.com>
References: <367215741E167A4CA813C8F12CE0143B3ED3AE@ausx2kmpc115.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED3AE@ausx2kmpc115.aus.amer.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 03:22:45PM -0500, Abhay_Salunke@Dell.com wrote:
> > > > I was assuming that this would wait forever, and is why I pointed you in
> > > > this direction.  Sorry about the confusion here.
> > > >
> > > I guess the earlier method of request_firmware would work out as is with
> > > the only disadvantage of the user having to depend on hotplug mechanism
> > > and echoing firmware name.
> > > Let me know if that is acceptable till we find a solution to wait for
> > > ever without using hotplug stuff.
> > 
> > Why not fix the firmware_class.c code now?  :)
> > 
> I can sure submit a patch later but for now please accept it in the
> tree. 

Heh, um, no.

> Due to scheduling issues it may not be possible for me to fix this now.

Please realize that we do not know, nor care about your scheduling
issues :)

For more details on "things you should never say on the Linux kernel
mailing list", see Randy Dunlap's very good presentation on kernel
development at:
	http://www.madrone.org/mentor/linux-mentoring.pdf

thanks,

greg k-h
