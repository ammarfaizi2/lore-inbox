Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266464AbSKGGZr>; Thu, 7 Nov 2002 01:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266468AbSKGGZr>; Thu, 7 Nov 2002 01:25:47 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:65042 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266464AbSKGGZq>;
	Thu, 7 Nov 2002 01:25:46 -0500
Date: Wed, 6 Nov 2002 22:28:16 -0800
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org, perex@suse.cz
Subject: Re: [PATCH] PnP MODULE_DEVICE_TABLE Update - 2.5.46 (3/6)
Message-ID: <20021107062816.GC26821@kroah.com>
References: <20021106210159.GN316@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106210159.GN316@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 09:02:00PM +0000, Adam Belay wrote:
> 
> diff -ur --new-file a/include/linux/module.h b/include/linux/module.h
> --- a/include/linux/module.h	Wed Oct 30 17:45:58 2002
> +++ b/include/linux/module.h	Wed Oct 30 17:45:24 2002
> @@ -239,6 +239,8 @@
>   * The following is a list of known device types (arg 1),
>   * and the C types which are to be passed as arg 2.
>   * pci - struct pci_device_id - List of PCI ids supported by this module
> + * pnpc - struct pnpc_device_id - List of PnP card ids (PNPBIOS, ISA PnP) supported by this module
> + * pnp - struct pnp_device_id - List of PnP ids (PNPBIOS, ISA PnP) supported by this module

I must have missed this last time, but to refresh my memory, why do you
need two different device types?  What's the difference between a card
id and a device id?

thanks,

greg k-h
