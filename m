Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVFIRr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVFIRr1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 13:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbVFIRr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 13:47:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43690 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262423AbVFIRrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 13:47:22 -0400
Date: Thu, 9 Jun 2005 10:49:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB bugfixes and a PCI one too for 2.6.12-rc6
In-Reply-To: <20050609164345.GA9538@kroah.com>
Message-ID: <Pine.LNX.4.58.0506091045590.2286@ppc970.osdl.org>
References: <20050609164345.GA9538@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Jun 2005, Greg KH wrote:
> 
> Please pull from:
> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
> 
>  drivers/block/ub.c                      |   10 -
>  drivers/pci/hotplug/cpci_hotplug_core.c |    4 
>  drivers/pci/hotplug/cpci_hotplug_pci.c  |   10 +
>  drivers/usb/serial/ftdi_sio.c           |  236 ++++++++++++++++++++++++--------
>  4 files changed, 198 insertions(+), 62 deletions(-)

Hmm.. I see the three commits you mention, but this doesn't match what I
get:

	 drivers/block/ub.c                      |    4 +
	 drivers/pci/hotplug/cpci_hotplug_core.c |    2 +
	 drivers/pci/hotplug/cpci_hotplug_pci.c  |    5 +
	 drivers/usb/serial/ftdi_sio.c           |  118 ++++++++++++++++++++++++-------
	 4 files changed, 99 insertions(+), 30 deletions(-)

whazzup?

		Linus
