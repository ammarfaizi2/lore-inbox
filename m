Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264294AbTEZF5S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbTEZF5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:57:18 -0400
Received: from dp.samba.org ([66.70.73.150]:58509 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264294AbTEZF5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:57:13 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Smith <whydoubt@yahoo.com>
Cc: linux-kernel@vger.kernel.org, coreteam@netfilter.org,
       zippel@linux-m68k.org
Subject: Re: [netfilter-core] [2.5.69 PATCH] - Trivial patch to Netfilter Kconfig 
In-reply-to: Your message of "Sat, 24 May 2003 14:10:42 MST."
             <20030524211042.92433.qmail@web40016.mail.yahoo.com> 
Date: Mon, 26 May 2003 16:01:27 +1000
Message-Id: <20030526061024.5DA2C2C26E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030524211042.92433.qmail@web40016.mail.yahoo.com> you write:
> @@ -120,7 +120,7 @@
>         tristate "Packet type match support"
>         depends on IP_NF_IPTABLES
>         help
> -         This patch allows you to match packet in accrodance
> +         Packet type matching allows you to match a packet in accordance
>           to its "class", eg. BROADCAST, MULTICAST, ...
> 
>           Typical usage:

It's still a little convoluted 8)

How about:

         help
         Packet type matching allows you to match a packet by
         its "class", eg. BROADCAST, MULTICAST, ...

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
