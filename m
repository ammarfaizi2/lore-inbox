Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVAWGy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVAWGy2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 01:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVAWGy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 01:54:28 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:39896 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261236AbVAWGyY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 01:54:24 -0500
Subject: Re: module's parameters could not be set via sysfs in 2.6.11-rc1?
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050114005948.GD4140@kroah.com>
References: <200501132234.30762.rathamahata@ehouse.ru>
	 <20050114005948.GD4140@kroah.com>
Content-Type: text/plain
Date: Sun, 23 Jan 2005 07:54:21 +0100
Message-Id: <1106463261.8118.13.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > It looks like module parameters are not setable via sysfs in 2.6.11-rc1
> > 
> > E.g.
> > arise parameters # echo -en Y > /sys/module/usbcore/parameters/old_scheme_first
> > -bash: /sys/module/usbcore/parameters/old_scheme_first: Permission denied
> > arise parameters # id
> > uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel),11(floppy),20(dialout),26(tape),27(video)
> > arise parameters # 
> > arise parameters # ls -la /sys/module/usbcore/parameters/old_scheme_first
> > -rw-r--r--  1 root root 0 Jan 13 22:22 /sys/module/usbcore/parameters/old_scheme_first
> > arise parameters # 
> > 
> > This is sad because it seems that my usb flash stick (transcebd jetflash)
> > doesn't like new USB device initialization scheme introduced in 2.6.10.
> 
> I'm seeing the same problem here.  I'll dig into it later tonight.

any updates on this? It still results in a permission denied with a
recent 2.6.11-rc2 kernel.

Regards

Marcel


