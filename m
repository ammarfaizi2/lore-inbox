Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVE2PMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVE2PMf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 11:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVE2PMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 11:12:35 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59913 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261337AbVE2PMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 11:12:33 -0400
Date: Sun, 29 May 2005 17:12:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Duncan Sands <baldrick@free.fr>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
Subject: 2.6.12-rc5-mm1: drivers/usb/atm/speedtch.c: gcc 2.95 compile error
Message-ID: <20050529151231.GE10441@stusta.de>
References: <20050525134933.5c22234a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050525134933.5c22234a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following compile error with gcc 2.95 seems to be caused by 
broken-out/gregkh-usb-usb-usbatm-{1,2}.patch:

<--  snip  -->

...
  CC      drivers/usb/atm/speedtch.o
drivers/usb/atm/speedtch.c: In function `speedtch_check_status':
drivers/usb/atm/speedtch.c:447: parse error before `;'
drivers/usb/atm/speedtch.c:456: parse error before `;'
drivers/usb/atm/speedtch.c:463: parse error before `;'
drivers/usb/atm/speedtch.c: In function `speedtch_status_poll':
drivers/usb/atm/speedtch.c:507: parse error before `;'
drivers/usb/atm/speedtch.c: In function `speedtch_handle_int':
drivers/usb/atm/speedtch.c:550: parse error before `;'
drivers/usb/atm/speedtch.c:552: parse error before `;'
make[3]: *** [drivers/usb/atm/speedtch.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

