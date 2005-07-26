Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVGZAHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVGZAHu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 20:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVGZAG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 20:06:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:18889 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261521AbVGZAGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 20:06:21 -0400
Date: Mon, 25 Jul 2005 17:06:00 -0700
From: Greg KH <greg@kroah.com>
To: Rajat Jain <rajat.noida.india@gmail.com>
Cc: kernelnewbies@nl.linux.org, linux-scsi@vger.kernel.org,
       linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Incorrect driver getting loaded for Qlogic FC-HBA
Message-ID: <20050726000600.GB23858@kroah.com>
References: <b115cb5f0507241902653b6f72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b115cb5f0507241902653b6f72@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 11:02:39AM +0900, Rajat Jain wrote:
> I'm using Kernel 2.6.9 and am having a Qlogic QLE2362 FC-HBA in my
> system. I selected all the Qlogic SCSI drivers while buiding the
> kernel. Now the problem is that every time I reboot, I have to
> MANUALLY modprobe the qla2322.ko module in the kernel and only then my
> HBA works. By default, the kernel loads qla2300.ko, which is not the
> correct driver for the card, and hence the HBA does not work. Here is
> the lspci output:

"by default" the kernel does not load any modules.  That's up to the
hotplug system, or some other package.

thanks,

greg k-h
