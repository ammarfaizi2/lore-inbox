Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVISHuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVISHuh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 03:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbVISHuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 03:50:37 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:55190 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S932365AbVISHug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 03:50:36 -0400
Subject: Re: USB bulk transfer device driver
From: Nazim Khan <nazim@verismonetworks.com>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B055A11@mail.esn.co.in>
References: <3AEC1E10243A314391FE9C01CD65429B055A11@mail.esn.co.in>
Content-Type: text/plain
Message-Id: <1127116056.3872.80.camel@nazim.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Sep 2005 13:17:36 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srini,

It depends what class of USB your driver falls in.
Linux already has generic classes drivers built into the kernel and if
your device complies with the standard you should be able to straight
away using the standard drivers.

i.e. USB Disk, its a mass storage device which uses bulk transfer. You
don't have to write any driver for this. Just enable appropriate options
in the kernel config, rebuild the kernel and attach your disk.

The disk should appear as a scsi device. (see the kernel boot up
messages).

Hope this helps.

Nazim

On Thu, 2005-09-08 at 12:23, Srinivas G. wrote:
> Dear all,
>  
> I want to develop a Linux driver for my USB device which uses "Bulk Transfer" data flow.
> Can I get a free source code or sample code for this type of driver?
>  
> Thanks in advance.
> 
> Regards,
> Srinivas G
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nazim Khan,
Verismo Networks India Pvt. Ltd.
Bangalore, India

