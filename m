Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUCOPbc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 10:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbUCOPbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 10:31:32 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:46736 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262605AbUCOPb3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 10:31:29 -0500
Message-ID: <4055CC48.6060200@stesmi.com>
Date: Mon, 15 Mar 2004 16:31:20 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7a) Gecko/20040219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Hogue <hogue@cs.yorku.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA on 2.4.x
References: <Pine.LNX.4.58.0403150934590.21510@wormwood.cs.yorku.ca>
In-Reply-To: <Pine.LNX.4.58.0403150934590.21510@wormwood.cs.yorku.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Hogue wrote:
> Hi,
> 
> I am using a via8237 southbridge with sata support.  I know that there is
> support for this in 2.6.x but I cannot use 2.6.x due to some
> incompatibility with my hardware.
> 
> Is there a patch to allow the via 8237 sata controller to work for kernel
> 2.4.x ?
> 
> Thanks,
> 
> -- Andrew
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I've used the libata driver for it (makes it appear as a SCSI device)
and it's worked fine for me but I've stopped using it after finding
out about trouble with that controller. If you have a second sata
controller on board, like a promise for instance, use that instead.

You still need libata in that case though.

Trouble with the controller is that three motherboards from three
manufacturers have eaten* three harddrives for me.

There are numerous threads on the net about people experiencing
similar effects as I did ..

// Stefan

* Ate = had to RMA.
