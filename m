Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTD3WAF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTD3WAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:00:05 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:39592 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262456AbTD3WAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:00:04 -0400
Date: Wed, 30 Apr 2003 18:12:13 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200304302212.h3UMCDV00426@devserv.devel.redhat.com>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68-bk10 - usbkbd.c compilation error
In-Reply-To: <mailman.1051727220.20780.linux-kernel2news@redhat.com>
References: <mailman.1051727220.20780.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   gcc -Wp,-MD,drivers/usb/input/.usbkbd.o.d -D__KERNEL__ -Iinclude -Wall
> -DKBUILD_MODNAME=usbkbd -c -o drivers/usb/input/.tmp_usbkbd.o
> drivers/usb/input/usbkbd.c

Just curious, why do you use usbkbd and usbmouse?
I think they should have been removed from the kernel long ago.

-- Pete
