Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292684AbSBUSBR>; Thu, 21 Feb 2002 13:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292683AbSBUSBI>; Thu, 21 Feb 2002 13:01:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4616 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292685AbSBUSAs>; Thu, 21 Feb 2002 13:00:48 -0500
Subject: Re: [PATCH] 2.5.5 IDE cleanup 11
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Thu, 21 Feb 2002 18:14:49 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3C75351D.4030200@evision-ventures.com> from "Martin Dalecki" at Feb 21, 2002 06:57:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dxk1-0007kN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So you didnt test or consider the upcoming things like hotplug. 
> 
> I did plugging and unplugging a CardBus IDE contoller in and out on
> a hot system.

IDE hotplug is device level (hence you want ->present)

> using the struct device_driver infrastructure and not by reduplicating 
> it's fuctionality inside ide.c. Agreed? Before one could even thing

Not agreed - its a layer lower I'm talking about
