Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266050AbTFWN6e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 09:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266051AbTFWN6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 09:58:34 -0400
Received: from granite.he.net ([216.218.226.66]:55823 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S266050AbTFWN6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 09:58:33 -0400
Date: Mon, 23 Jun 2003 07:07:02 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.73 : undefined reference to pci_destroy_dev
Message-ID: <20030623140702.GA8440@kroah.com>
References: <3EF6F942.7090506@wanadoo.fr> <6u7k7dndvd.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6u7k7dndvd.fsf@zork.zork.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 02:05:10PM +0100, Sean Neakums wrote:
> Rémi COLINET <remi.colinet@wanadoo.fr> writes:
> 
> > Making bzImage with 2.5.73, I'm getting the following undefined reference.
> > I have to set the PCI hotplug in my .config file in order to get the
> > bzImage.
> >
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > drivers/built-in.o: In function `pci_remove_bus_device':
> > drivers/built-in.o(.text+0x367b): undefined reference to `pci_destroy_dev'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> Grek KH posted a patch for this.

Or you can just enable CONFIG_HOTPLUG.

thanks,

greg k-h
