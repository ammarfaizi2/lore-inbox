Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVCOKux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVCOKux (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 05:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVCOKux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 05:50:53 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:29330 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262377AbVCOKua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 05:50:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dl3A1iyvh6COZnvpwsHUS444Lcx2Z5bqx3bGTaFWBB6mWjPSZrjBUjbSxTFc+qAeek5ytglmJessLr8KZDDIs9GTMnu1BulnnmrYD2MjhcPWMjox1F+07S9SFhP+5VIHcTKpvYe7nYWgIeq3QgBoqoG4e9k7FPkM63BMRDSnZQo=
Message-ID: <21d7e99705031502507704f50f@mail.gmail.com>
Date: Tue, 15 Mar 2005 10:50:28 +0000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Andrew Clayton <andrew@digital-domain.net>
Subject: Re: Problem with 2.6.11-bk[3456]
Cc: lkml <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1110492499.2666.8.camel@alpha.digital-domain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <1110492499.2666.8.camel@alpha.digital-domain.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Got a problem here with the last few Linus -bk releases.
> 
> 2.6.11-bk2 is running fine.
> 
> 2.6.11-bk3 - 2.6.11-bk6 has the following problem:
> 
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
> I've put 2.6.11-bk2 and 2.6.11-bk6 config's, dmesg's and an lspc -vv up
> on the web.
> 
> http://digital-domain.net/kernel/2.6.11-bk2.config
> http://digital-domain.net/kernel/2.6.11-bk6.config
> http://digital-domain.net/kernel/2.6.11-bk2.dmesg
> http://digital-domain.net/kernel/2.6.11-bk6.dmesg
> http://digital-domain.net/kernel/lspci-vv
> 
> When looking at this the other day I did get a message on the serial
> console after X started and the machine locked, about uhci host
> controller being disabled or something. Unfortunately I didn't make a
> note of it and didn't get it today for when I was preparing this report.
> 
> Looking at the two dmesg's there is some difference in the usb messages.
> 
> Anyway, thanks for your time and if you need any more info just let me
> know.

This is the same problem as i just mailed everyone about.. more
information here...

Dave.
