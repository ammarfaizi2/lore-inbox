Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265101AbSJXANh>; Wed, 23 Oct 2002 20:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265265AbSJXANh>; Wed, 23 Oct 2002 20:13:37 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:5135 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265101AbSJXANg>;
	Wed, 23 Oct 2002 20:13:36 -0400
Date: Wed, 23 Oct 2002 17:18:18 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorquk.ukuu.org.uk
Subject: Re: [PATCH] Advanced TCA SCSI/FC disk hotswap driver for kernel 2.5.44
Message-ID: <20021024001818.GH17413@kroah.com>
References: <3DB7304A.3030903@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB7304A.3030903@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 04:27:06PM -0700, Steven Dake wrote:
> 
> Changes from kernel 2.4.19 to 2.5.44 release:

First off, your patch is line wrapped, please fix your email client.

Also, please read Documentation/CodingStyle and use tabs.  Unless this
is a side effect of your email client munging the patch.

> * ioctls deleted and replaced by ramfs scsi_hotswap_fs (suggested by
> Greg KH)

Any reason you can't use driverfs for the 2.5 code?


> +/*
> + * Core file read/write operations interfaces
> + */
> +static char scsi_hotswap_insert_by_scsi_id_usage[] = {
> +    "Usage: echo \"[host] [channel] [lun] [id]\" > insert_by_scsi_id\n"
> +};

I really like this, a user friendly kernel interface :)

thanks,

greg k-h
