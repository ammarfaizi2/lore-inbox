Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWCCPcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWCCPcO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 10:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWCCPcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 10:32:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53769 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751098AbWCCPcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 10:32:14 -0500
Date: Fri, 3 Mar 2006 16:32:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Tilman Schmidt <tilman@imap.cc>,
       Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: 2.6.16-rc5-mm1: USB compile errors
Message-ID: <20060303153213.GS9295@stusta.de>
References: <20060228042439.43e6ef41.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228042439.43e6ef41.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 04:24:39AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc4-mm2:
>...
> +gregkh-usb-usb-reduce-syslog-clutter.patch
> 
>  USB tree update
>...

This patch causes tons of comile errors like the following in 
non-modular drivers:

<--  snip  -->

...
  CC      drivers/input/joystick/iforce/iforce-usb.o
drivers/input/joystick/iforce/iforce-usb.c: In function 'iforce_usb_irq':
drivers/input/joystick/iforce/iforce-usb.c:104: error: dereferencing pointer to incomplete type
make[4]: *** [drivers/input/joystick/iforce/iforce-usb.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

