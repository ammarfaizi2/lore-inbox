Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262245AbRERDxl>; Thu, 17 May 2001 23:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262246AbRERDxV>; Thu, 17 May 2001 23:53:21 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:2308 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S262245AbRERDxM>; Thu, 17 May 2001 23:53:12 -0400
Date: Thu, 17 May 2001 23:52:52 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@portland.hansa.lan>
To: Zilvinas Valinskas <zvalinskas@carolina.rr.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VIA/PDC/Athlon
Message-ID: <Pine.LNX.4.33.0105172131230.5744-100000@portland.hansa.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Zilvinas!

There are utilities that work with PnP BIOS. They are included with
pcmcia-cs (which is weird - it should be a separate package) and called
"lspci" and "setpci". They depend on PnP BIOS support in the kernel
(CONFIG_PNPBIOS).

Dumping your PnP BIOS configuration and checking whether it has changed
after booting to Windows would be more reasonable than checking your PCI
configuration (IMHO).

-- 
Regards,
Pavel Roskin

