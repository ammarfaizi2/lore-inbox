Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137029AbREKCVe>; Thu, 10 May 2001 22:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137030AbREKCVY>; Thu, 10 May 2001 22:21:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20997 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S137029AbREKCVM>; Thu, 10 May 2001 22:21:12 -0400
Subject: Re: eepro100/usb interrupts stop with 2.4.x kernels?
To: poole@troilus.org (Michael Poole)
Date: Fri, 11 May 2001 10:37:50 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3wv7od9hu.fsf@troilus.org> from "Michael Poole" at May 10, 2001 08:17:49 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14y9Mt-0002GH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What seems to happen is that the kernel stops seeing interrupts on the
> IRQ shared by eth0 (my outside interface) and usb-uhci.  I can still
> ssh in on eth1, and when I do, syslog contains things like "eth0:
> Interrupt timed out" and usb-uhci griping about devices that failed to
> accept new endpoints.

Do you see this if you run a -ac kernel or apply the APIC 440BX patch ?
