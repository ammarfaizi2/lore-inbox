Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWC2AXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWC2AXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWC2AXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:23:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9431 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964878AbWC2AXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:23:13 -0500
Date: Tue, 28 Mar 2006 16:23:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 0/4] LED Updates
Message-Id: <20060328162300.5bf4f4fc.akpm@osdl.org>
In-Reply-To: <1143591415.14682.55.camel@localhost.localdomain>
References: <1143591415.14682.55.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie <rpurdie@rpsys.net> wrote:
>
> ...
>
> Also add some missing externs.
>
> ... 
>  
>  /* Registration functions for complex triggers */
> -int led_trigger_register(struct led_trigger *trigger);
> -void led_trigger_unregister(struct led_trigger *trigger);
> +extern int led_trigger_register(struct led_trigger *trigger);
> +extern void led_trigger_unregister(struct led_trigger *trigger);

Well.  The externs weren't "missing".  They were "unnecessary".  I don't
know why we do this really - it doesn't communicate any information.  Oh
well.

