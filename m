Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262816AbUKTAeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbUKTAeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbUKTAcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:32:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:51852 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262816AbUKTA2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:28:19 -0500
Date: Fri, 19 Nov 2004 16:27:48 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux support for SiLabs CP2102 devices
Message-ID: <20041120002748.GA19943@kroah.com>
References: <mailman.1100831940.24470.linux-kernel2news@redhat.com> <20041119162255.607e9be2@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119162255.607e9be2@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 04:22:55PM -0800, Pete Zaitcev wrote:
> On Thu, 18 Nov 2004 09:39:08 -0800, Greg KH <greg@kroah.com> wrote:
> 
> > If people are looking for a good usb to serial chip that is supported on
> > Linux, Windows, and OS-X, there's the PL2303 device from Prolific, and
> > the FTDI-SIO chip, and the MCT-U232 chip.  All of these work very well
> > on Linux, and are fully supported by all distros.  I think they even
> > might be cheaper than the CP2102 device too :)
> 
> The Magic Technology has ignored my requests to provide documentation for
> either Intel or Phillips based version of their kit. The mct_u232 was
> developed by reverse engineering the code, so it's probably not a good
> example.

Ah, didn't realize that.  Actually, the pl2303 driver was reverse
engineered too, with no specs, and now the company referrs people asking
questions about their Linux support to me :)

> Why did you omit Keyspan? I thought they had reasonable policies, if we
> ignore debian-legal issue for the moment.

I was pointing out usb to serial chips that people could put into their
product design.  Keyspan doesn't offer up such a chip, only a complete
solution of a usb to serial converter (from what I can tell.)

thanks,

greg k-h
