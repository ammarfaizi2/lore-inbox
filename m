Return-Path: <linux-kernel-owner+w=401wt.eu-S932503AbXATACp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbXATACp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 19:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932870AbXATACp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 19:02:45 -0500
Received: from cantor2.suse.de ([195.135.220.15]:43608 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932503AbXATACo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 19:02:44 -0500
Date: Fri, 19 Jan 2007 16:01:58 -0800
From: Greg KH <greg@kroah.com>
To: Udo van den Heuvel <udovdh@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB extension (repeater) cable
Message-ID: <20070120000158.GD12615@kroah.com>
References: <45B0E672.4080404@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45B0E672.4080404@xs4all.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2007 at 04:40:34PM +0100, Udo van den Heuvel wrote:
> Hello,
> 
> I just tried my shiny new usb extension cable (repeater):
> 
> Jan 19 16:01:17 epia kernel: usb 5-1: new high speed USB device using
> ehci_hcd and address 60
> Jan 19 16:01:17 epia kernel: usb 5-1: configuration #1 chosen from 1 choice
> Jan 19 16:01:17 epia kernel: hub 5-1:1.0: USB hub found
> Jan 19 16:01:17 epia kernel: hub 5-1:1.0: 4 ports detected
> Jan 19 16:01:18 epia kernel: hub 5-1:1.0: Cannot enable port 1.  Maybe
> the USB cable is bad?
> Jan 19 16:01:22 epia last message repeated 3 times
> Jan 19 16:01:23 epia kernel: hub 5-1:1.0: Cannot enable port 2.  Maybe
> the USB cable is bad?
> Jan 19 16:01:26 epia last message repeated 3 times
> Jan 19 16:01:27 epia kernel: hub 5-1:1.0: Cannot enable port 3.  Maybe
> the USB cable is bad?
> Jan 19 16:01:31 epia last message repeated 3 times
> 
> The second cable does the same.
> Of course we have just one port on this hub...
> Any ideas?

Perhaps the kernel is not lying and this cable really is bad?  :)

Your hardware can not handle this device, there really is nothing that
the kernel can do about this.

USB extension cables are horrible things, and usually violate the USB
spec and do not always work, as you are finding out.  Sorry about that.

good luck,

greg k-h
