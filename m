Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbTKPPir (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 10:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbTKPPir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 10:38:47 -0500
Received: from mail2-116.ewetel.de ([212.6.122.116]:725 "EHLO mail2.ewetel.de")
	by vger.kernel.org with ESMTP id S262965AbTKPPiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 10:38:46 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fix firmware loader docs
In-Reply-To: <SuZ1.4nW.9@gated-at.bofh.it>
References: <SuZ1.4nW.9@gated-at.bofh.it>
Date: Sun, 16 Nov 2003 16:38:38 +0100
Message-Id: <E1ALOz0-0000I5-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Nov 2003 14:20:15 +0100, you wrote in linux.kernel:

> AFAICS, sysfs should be mounted on /sys these days...
> 
> --- tmp/linux/Documentation/firmware_class/README	2003-08-27 12:00:01.000000000 +0200
> +++ linux/Documentation/firmware_class/README	2003-11-06 13:50:58.000000000 +0100
> @@ -60,9 +60,9 @@
>  
>  	HOTPLUG_FW_DIR=/usr/lib/hotplug/firmware/
>  
> -	echo 1 > /sysfs/$DEVPATH/loading
> +	echo 1 > /sys/$DEVPATH/loading
>  	cat $HOTPLUG_FW_DIR/$FIRMWARE > /sysfs/$DEVPATH/data
> -	echo 0 > /sysfs/$DEVPATH/loading
> +	echo 0 > /sys/$DEVPATH/loading

You need more coffee. You forgot the /sysfs/ on the line with cat. ;)

-- 
Ciao,
Pascal
