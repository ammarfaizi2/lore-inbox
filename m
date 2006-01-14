Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWANWDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWANWDP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWANWDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:03:15 -0500
Received: from math.ut.ee ([193.40.36.2]:2731 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1751315AbWANWDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:03:14 -0500
Date: Sun, 15 Jan 2006 00:02:59 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Scott H Kilau <Scott_Kilau@digi.com>,
       Wendy Xiong <wendyx@us.ltcfwd.linux.ibm.com>
Subject: jsm serial driver broken with flip buffer changes
Message-ID: <Pine.SOC.4.61.0601142359120.15808@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In current 1.6.15+git jsm serial driver is broken:

   CC [M]  drivers/serial/jsm/jsm_tty.o
drivers/serial/jsm/jsm_tty.c: In function `jsm_input':
drivers/serial/jsm/jsm_tty.c:592: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:619: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:620: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:623: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:624: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:667: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:668: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:669: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:670: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:671: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:672: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:674: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:677: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:677: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:677: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:677: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:680: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:681: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:682: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:691: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:692: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:693: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:694: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:695: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:696: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:698: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:701: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:701: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:701: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:701: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:742: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:742: error: structure has no member named `flip'
make[3]: *** [drivers/serial/jsm/jsm_tty.o] Error 1

-- 
Meelis Roos (mroos@linux.ee)
