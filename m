Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262838AbVA2CUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbVA2CUY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 21:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbVA2CUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 21:20:24 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:24534 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262838AbVA2CUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 21:20:15 -0500
Message-ID: <41FAF2D8.1060207@comcast.net>
Date: Fri, 28 Jan 2005 21:20:08 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Wiegley <jeffw@cyte.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10 USB devices generate descriptor read error?
References: <41FAEF8F.9010809@cyte.com>
In-Reply-To: <41FAEF8F.9010809@cyte.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Known one - It's non fatal. All your devices should work fine.  If you 
want you can try loading usbcore.ko with module parameter 
old_scheme_first=y and see if it goes away.
Parag
Jeff Wiegley wrote:

> Is anybody else having a similar problem as the
> following...
>
> My USB keydrives use to work fine in 2.6.9.
> Since I upgraded to 2.6.10 now they just
> generate a device descriptor read error.
>
> Specifically:
>
> /var/log/kern.log.0:Jan 26 18:18:18 mail kernel: usb 4-2.1:
> device descriptor read/64, error -32
>
> Also I noticed that a new Sigmatel based USB IRDA
> device also produces similar messages...
>
> /var/log/kern.log:Jan 27 12:31:19 mail kernel: usb 2-2: device
> descriptor read/64, error -71
>
> Is this a known problem or is it just me?
>
> I noticed that the precompiled debian 2.6.10 kernel
> works with at least the usb flash drive ok.  But my
> compiled version produces the above.
>
> But I don't think I changed any relevant kernel config
> items from 2.6.9 to 2.6.10 and I've compiled lots of
> USB enabled kernels before so I'd like to think I'm
> not an idiot but maybe I missed a new option or
> something.
>
> Please help,
>
> - Jeff
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

