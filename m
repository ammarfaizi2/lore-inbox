Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTJBBQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 21:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTJBBQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 21:16:26 -0400
Received: from dp.samba.org ([66.70.73.150]:24775 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263201AbTJBBQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 21:16:22 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Shine Mohamed <shinemohamed_j@naturesoft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initializedd the module parameters in drivers/net/wireless/arlan-main.c 
In-reply-to: Your message of "Mon, 29 Sep 2003 16:44:06 +0530."
             <200309291644.06043.shinemohamed_j@naturesoft.net> 
Date: Wed, 01 Oct 2003 19:01:04 +1000
Message-Id: <20031002011622.192752C2BC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200309291644.06043.shinemohamed_j@naturesoft.net> you write:
> Quick patch to  Initialize  the module parameters in 
> drivers/net/wireless/arlan-main.c
> @@ -33,6 +33,7 @@
>  static int retries = 5;
>  static int tx_queue_len = 1;
>  static int arlan_EEPROM_bad;
> +static int probe = 0; /* Initially it is setting to be 'Probing Disabled' */
> 
>  #ifdef ARLAN_DEBUGGING

This is clearly wrong: it's declared below.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
