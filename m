Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751067AbWFFBSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWFFBSW (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 21:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWFFBSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 21:18:22 -0400
Received: from havoc.gtf.org ([69.61.125.42]:31939 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751031AbWFFBSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 21:18:21 -0400
Date: Mon, 5 Jun 2006 21:18:18 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Greg KH <greg@kroah.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Greg KH <gregkh@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com,
        netdev@vger.kernel.org, mb@bu3sch.de, st3@riseup.net,
        linville@tuxdriver.com
Subject: Re: [PATCH 2/3] pci: bcm43xx avoid pci_find_device
Message-ID: <20060606011818.GA4135@havoc.gtf.org>
References: <2005123213211@nnikde.cz> <20060605202007.B464FC7B73@atrey.karlin.mff.cuni.cz> <20060605205309.GA31061@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605205309.GA31061@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 01:53:09PM -0700, Greg KH wrote:
> Why not just use the proper pci interface?  Why poke around in another
> pci device to steal an irq, when that irq might not even be valid?
> (irqs are not valid until pci_enable_device() is called on them...)

Answered this question the last time you asked.

Answer:  this is an embedded platform that needs such poking.  The
wireless device is _another_ device.

	Jeff



