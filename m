Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVGXTnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVGXTnU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 15:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVGXTnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 15:43:20 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:26550 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261254AbVGXTnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 15:43:11 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 test: finding compile errors with make randconfig
Date: Mon, 25 Jul 2005 05:42:58 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <glq7e1ttejp2sh7uuo6nil2vafljdprkpk@4ax.com>
References: <f8b6e1h2t4tlto7ia8gs8aanpib68mhit6@4ax.com> <20050724091327.GQ3160@stusta.de>
In-Reply-To: <20050724091327.GQ3160@stusta.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2005 11:13:27 +0200, Adrian Bunk <bunk@stusta.de> wrote:
>
>it's generally useful, but the target kernel should be the latest -mm
>kernel. 
097-error:drivers/char/drm/drm_memory.h:163: error: redefinition of `drm_ioremap_nocache'
097-error:drivers/char/drm/drm_memory.h:163: error: `drm_ioremap_nocache' previously defined here
097-error:drivers/char/drm/drm_memory.h:174: error: redefinition of `drm_ioremapfree'
097-error:drivers/char/drm/drm_memory.h:174: error: `drm_ioremapfree' previously defined here
098-error:drivers/usb/gadget/ether.c:2510: error: `STATUS_BYTECOUNT' undeclared (first use in this function)
098-error:drivers/usb/gadget/ether.c:2510: error: (Each undeclared identifier is reported only once
098-error:drivers/usb/gadget/ether.c:2510: error: for each function it appears in.)
grant@sempro:/opt/linux/trial4$ grep error *-error |wc -l
2105

With > 2k (raw) errors in 97.something builds of 2.6.12.3, why go 
looking for trouble in -mm?  
>
>And doing the compilations is really the trivial part of the work, the 
Got to start somewhere :)  

Grant.

