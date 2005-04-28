Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVD1FYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVD1FYD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 01:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVD1FYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 01:24:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:37068 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262007AbVD1FX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 01:23:59 -0400
Date: Wed, 27 Apr 2005 22:23:36 -0700
From: Greg KH <greg@kroah.com>
To: Joe <joecool1029@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Device Node Issues with recent mm's and udev
Message-ID: <20050428052335.GA10772@kroah.com>
References: <d4757e6005042716523af66bae@mail.gmail.com> <20050428041428.GB9723@kroah.com> <d4757e6005042721577ba48cc@mail.gmail.com> <20050428050346.GB10182@kroah.com> <d4757e6005042722207e2b926@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4757e6005042722207e2b926@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 01:20:32AM -0400, Joe wrote:
> On 4/28/05, Greg KH <greg@kroah.com> wrote:
> > On Thu, Apr 28, 2005 at 12:57:46AM -0400, Joe wrote:
> > > It also seems to have trouble recreating the node even when the file
> > > has been deleted
> > 
> > "trouble" how?
> > 
> 
> Apparantly the other partitions of the device (ex. sdb1, sdb3) are
> still considered nodes.  udev also seems to ignore them and hotplug
> does not remove these nodes when the device is unplugged.
> 
> Additionally, when plugged back in, the device won't recreate the
> nodes unless ALL of them are deleted, and even then its a hit and miss
> as to whether it will decide to create them.

Again, usb or firewire?
And if usb, are you _sure_ there are no kernel log messages?  There
should be something there...

Otherwise I have no idea what is happening, and don't know how to find
out either :(

thanks,

greg k-h
