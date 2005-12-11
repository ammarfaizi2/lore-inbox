Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVLKGfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVLKGfo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 01:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVLKGfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 01:35:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:485 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932249AbVLKGfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 01:35:43 -0500
Date: Sat, 10 Dec 2005 22:35:22 -0800
From: Greg KH <greg@kroah.com>
To: Ashutosh Naik <ashutosh.naik@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BUG] Early Kernel Panic with 2.6.15-rc5
Message-ID: <20051211063522.GA23621@kroah.com>
References: <81083a450512102211r608cee8wc16cc19565a1488f@mail.gmail.com> <81083a450512102226q1443f09bof0d3ba2bd5a1be2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81083a450512102226q1443f09bof0d3ba2bd5a1be2@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 11:56:08AM +0530, Ashutosh Naik wrote:
> CONFIG_HOTPLUG_PCI_PCIE=y

Change this to "m" or "n" and the oops should go away.  It's a known
problem that is being worked on, but will probably take a while to get
done.

Do you really have a pci express hotplug controller on this machine?

thanks,

greg k-h
