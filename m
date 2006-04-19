Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWDSTwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWDSTwU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWDSTwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:52:20 -0400
Received: from cantor.suse.de ([195.135.220.2]:42470 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751204AbWDSTwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:52:19 -0400
Date: Wed, 19 Apr 2006 12:50:38 -0700
From: Greg KH <greg@kroah.com>
To: Nicolas Boichat <nicolas@boichat.ch>
Cc: Stelian Pop <stelian@popies.net>,
       YOSHIFUJI Hideaki / ???????????? <yoshfuji@linux-ipv6.org>,
       linux-usb-devel@lists.sourceforge.net, johannes@sipsolutions.net,
       mactel-linux-devel@lists.sourceforge.net, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org, frank@scirocco-5v-turbo.de,
       petero2@telia.com, linux-kernel@hansmi.ch
Subject: Re: [PATCH] MacBook Pro touchpad support
Message-ID: <20060419195038.GD19969@kroah.com>
References: <1145358431.14816.18.camel@localhost> <20060418.212525.21076744.yoshfuji@linux-ipv6.org> <1145373471.23139.10.camel@localhost.localdomain> <20060418164137.GA31841@kroah.com> <1145446432.5493.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145446432.5493.3.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 01:33:52PM +0200, Nicolas Boichat wrote:
> -		dprintk("appletouch: incomplete data package.\n");
> +		dprintk("appletouch: incomplete data package (first byte: %d, length: %d).\n", dev->data[0], dev->urb->actual_length);

This line is a bit long, please fix things to follow the kernel coding
style to fit within 80 columns.

thanks,

greg k-h
