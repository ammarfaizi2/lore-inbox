Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVE2Op5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVE2Op5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 10:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVE2Op5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 10:45:57 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32521 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261332AbVE2Opu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 10:45:50 -0400
Date: Sun, 29 May 2005 16:45:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Johannes Stezenbach <js@linuxtv.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Subject: 2.6.12-rc5-mm1: drivers/media/dvb/dvb-usb/a800.c compile error
Message-ID: <20050529144548.GC10441@stusta.de>
References: <20050525134933.5c22234a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050525134933.5c22234a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 01:49:33PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.12-rc4-mm2:
>...
> +add-generalized-dvb-usb-driver.patch
>...
>  DVB updates
>...

It seems this patch is responsible for the following compile error with 
gcc 2.95:

<--  snip  -->

...
  CC      drivers/media/dvb/dvb-usb/a800.o
In file included from drivers/media/dvb/dvb-usb/dibusb.h:15,
                 from drivers/media/dvb/dvb-usb/a800.c:16:
drivers/media/dvb/dvb-usb/dvb-usb.h:196: field `devices' has incomplete type
...
make[4]: *** [drivers/media/dvb/dvb-usb/a800.o] Error 1

<--  snip -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

