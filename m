Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263022AbTHVFln (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 01:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbTHVFln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 01:41:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:28055 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263022AbTHVFlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 01:41:42 -0400
Date: Thu, 21 Aug 2003 22:20:00 -0700
From: Greg KH <greg@kroah.com>
To: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] 2/10 2.4.22-rc2 fix __FUNCTION__ warnings drivers/hotplug
Message-ID: <20030822052000.GA7589@kroah.com>
References: <20030821012932.7179f30c.vmlinuz386@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030821012932.7179f30c.vmlinuz386@yahoo.com.ar>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 01:29:32AM -0300, Gerardo Exequiel Pozzi wrote:
>  cpqphp.h           |    6 ++--
>  cpqphp_core.c      |   30 +++++++++++------------
>  cpqphp_ctrl.c      |   68 ++++++++++++++++++++++++++---------------------------
>  cpqphp_nvram.c     |    2 -
>  cpqphp_pci.c       |   12 ++++-----
>  pci_hotplug_core.c |    2 -
>  pci_hotplug_util.c |    2 -
>  7 files changed, 61 insertions(+), 61 deletions(-)
> 
> http://www.vmlinuz.com.ar/slackware/patch/kernel/drivers.hotplug.patch
> http://www.vmlinuz.com.ar/slackware/patch/kernel/drivers.hotplug.patch.asc

$ wget http://www.vmlinuz.com.ar/slackware/patch/kernel/drivers.hotplug.patch
--22:18:07--  http://www.vmlinuz.com.ar/slackware/patch/kernel/drivers.hotplug.patch
           => `drivers.hotplug.patch'
Resolving www.vmlinuz.com.ar... done.
Connecting to www.vmlinuz.com.ar[65.200.24.183]:80... connected.
HTTP request sent, awaiting response... 404 Not Found
22:18:36 ERROR 404: Not Found.



Please send send patches inline in email messages to the maintainers of
the code that you are modifying, like Documentation/SubmittingPatches
says to.

thanks,

greg k-h
