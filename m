Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVAJHHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVAJHHG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 02:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVAJHHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 02:07:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:54243 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262127AbVAJHHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 02:07:01 -0500
Date: Sun, 9 Jan 2005 23:04:38 -0800
From: Greg KH <greg@kroah.com>
To: "Bhupesh Kumar Pandey, Noida" <bhupeshp@noida.hcltech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: regarding hotpluggable devices adn linux kernel
Message-ID: <20050110070438.GA13078@kroah.com>
References: <267988DEACEC5A4D86D5FCD780313FBB03500BDC@exch-03.noida.hcltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <267988DEACEC5A4D86D5FCD780313FBB03500BDC@exch-03.noida.hcltech.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 12:19:21PM +0530, Bhupesh Kumar Pandey, Noida wrote:
>  
> Actually I want to know the how hotplugging works under 2.6 and what is the
> information flow and how a user can do this.

Hotplug what?  That's a _very_ general term.  Hotplug CPU?  Hotplug
Memory?  Hotplug SCSI disk?  Hotplug USB device?  Hotplug keyboard?
Hotplug PCI device?  Hotplug IEEE1394 device?  Hotplug PCMCIA device?
The userspace /sbin/hotplug script?  The linux-hotplug script package?
and so on...

They all work differently, as they are all different things.

> Secondly is it support PnP of iSCSI disks? If yes then it has support in
> kernel or any patch is nedded? If no then what are the problems.

I do not know anything about iSCSI, sorry.  Try asking on the linux-scsi
mailing list.

greg k-h
