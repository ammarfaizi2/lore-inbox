Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVCVA3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVCVA3y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVCVA1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:27:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:12420 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262221AbVCVA0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:26:44 -0500
Date: Mon, 21 Mar 2005 16:26:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrew Clayton <andrew@digital-domain.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.6.11-bk[3456]
Message-Id: <20050321162638.2bd53b17.akpm@osdl.org>
In-Reply-To: <1110492499.2666.8.camel@alpha.digital-domain.net>
References: <1110492499.2666.8.camel@alpha.digital-domain.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Clayton <andrew@digital-domain.net> wrote:
>
> Hi,
> 
> Got a problem here with the last few Linus -bk releases.
> 
> 2.6.11-bk2 is running fine.
> 
> 2.6.11-bk3 - 2.6.11-bk6 has the following problem:

We had a bit of an AGP disaster between -bk2 and -bk3.  There's an
in-progress fix in 2.6.12-rc1-mm1.  Are you able to test that?


> Everything is fine while the machine is booting. However as soon as X
> starts up the screen goes blank as normal but stays blank, no gdm login
> screen and the hard disk and floppy drive lights are on continuously.
> The machine is now locked up solid and needs a hard reset.
> 
> I tried a serial console but get nothing after the kernel messages and
> the agetty login.
> 
> The machine is question is an UP Athlon 1800+ XP with 768MB RAM, the
> graphics card is an AGP ATI Radeon 9200SE using the kernel AGP/DRM
> drivers and the Xorg radeon driver.
> 
> It's running FC3.
> 
> 
> I've put 2.6.11-bk2 and 2.6.11-bk6 config's, dmesg's and an lspc -vv up
> on the web.
> 
> http://digital-domain.net/kernel/2.6.11-bk2.config
> http://digital-domain.net/kernel/2.6.11-bk6.config
> http://digital-domain.net/kernel/2.6.11-bk2.dmesg
> http://digital-domain.net/kernel/2.6.11-bk6.dmesg
> http://digital-domain.net/kernel/lspci-vv
> 
> 
> When looking at this the other day I did get a message on the serial
> console after X started and the machine locked, about uhci host
> controller being disabled or something. Unfortunately I didn't make a
> note of it and didn't get it today for when I was preparing this report.
> 
> Looking at the two dmesg's there is some difference in the usb messages.
> 
> 
> Anyway, thanks for your time and if you need any more info just let me
> know.
> 
> 
> Cheers,
> 
> Andrew Clayton
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
