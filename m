Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263504AbTJBVpQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 17:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263505AbTJBVpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 17:45:16 -0400
Received: from [66.212.224.118] ([66.212.224.118]:56328 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S263504AbTJBVpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 17:45:10 -0400
Date: Thu, 2 Oct 2003 17:45:04 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: reg@dwf.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 - Network doesn't come up.
In-Reply-To: <200310022138.h92Lc67x005420@orion.dwf.com>
Message-ID: <Pine.LNX.4.53.0310021744330.2108@montezuma.fsmlabs.com>
References: <200310022138.h92Lc67x005420@orion.dwf.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Oct 2003 reg@dwf.com wrote:

> OK, Im trying to run 2.6.0-test6 on top of RH9.
> I have progress in some areas but not others.
> 
> NETWORKING. is a nogo.
> 
> If I compile the driver 3c59x as a module, it gets loaded, but
> with the driver in the kernel or as a module, I get the messages
> in the messages file (during boot) or when I do a ./network start
> from /etc/rc.d/init.d

You may want to post your .config, i'm using 3c59x in kernel and have 
working networking.

> [root@orion init.d]# ./network* restart
> Shutting down interface eth0:                              [  OK  ]
> Shutting down loopback interface:                          [  OK  ]
> Setting network parameters:                                [  OK  ]
> Bringing up loopback interface:  arping: socket: Address family not supported 
> by protocol
> Error, some other host already uses address 127.0.0.1.
>                                                            [FAILED]
> Bringing up interface eth0:  arping: socket: Address family not supported by 
> protocol
> Error, some other host already uses address 204.134.2.19.
>                                                            [FAILED]
> 
> ---
> 
>                                         Reg.Clemens
>                                         reg@dwf.com
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
