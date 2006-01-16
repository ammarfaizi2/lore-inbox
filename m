Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWAPV0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWAPV0L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 16:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWAPV0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 16:26:10 -0500
Received: from [200.91.100.172] ([200.91.100.172]:51514 "EHLO
	IPOfCard1.guest-tek.com") by vger.kernel.org with ESMTP
	id S1751209AbWAPV0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 16:26:09 -0500
Message-ID: <43CC0F74.9090409@linuxwireless.org>
Date: Mon, 16 Jan 2006 15:26:12 -0600
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: drivers/block/ps2esdi.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the Linux-2.6 tree is still broken...

Just FYI


  CC      drivers/block/loop.o
  CC      drivers/block/ps2esdi.o
In file included from drivers/block/ps2esdi.c:42:
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please 
move your driver to the new sysfs api"
drivers/block/ps2esdi.c: In function 'ps2esdi_getgeo':
drivers/block/ps2esdi.c:1064: error: dereferencing pointer to incomplete 
type
drivers/block/ps2esdi.c:1065: error: dereferencing pointer to incomplete 
type
drivers/block/ps2esdi.c:1066: error: dereferencing pointer to incomplete 
type
make[3]: *** [drivers/block/ps2esdi.o] Error 1
make[2]: *** [drivers/block] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/root/linux-2.6'
make: *** [debian/stamp-build-kernel] Error 2
debian:~/linux-2.6#
