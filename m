Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbTHTXV5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 19:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbTHTXV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 19:21:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25040 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262325AbTHTXVz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 19:21:55 -0400
Message-ID: <3F440286.5080009@pobox.com>
Date: Wed, 20 Aug 2003 19:21:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix bug 923 for sis900 driver
References: <20030820223713.GB5138@kroah.com>
In-Reply-To: <20030820223713.GB5138@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Hi,
> 
> I realized that I've had this patch in my tree for a while, and forgot
> to send it to you and lkml.  The patch below fixes bug number 923:
> 	http://bugme.osdl.org/show_bug.cgi?id=923
> (basically keeps us from calling pci_find_device from interrupt
> context.)
> 
> It's been tested by a few people with this device, and they say it works
> just fine for them.  Please forward it on up the food chain.
> 
> thanks,
> 
> greg k-h
> 
> 
> diff -Nru a/drivers/net/sis900.c b/drivers/net/sis900.c
> --- a/drivers/net/sis900.c	Wed Aug 20 15:29:35 2003
> +++ b/drivers/net/sis900.c	Wed Aug 20 15:29:35 2003


Looks good, will apply later on today.

Thanks,

	Jeff


