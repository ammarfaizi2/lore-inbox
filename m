Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbULAWh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbULAWh5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbULAWhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:37:45 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:43173 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261478AbULAWh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:37:26 -0500
Subject: Re: "irq 16: nobody cared!" -errors after motherboard-switch (ABIT
	IS7-E2 motherboard)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: K G <gege86hu@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041201174010.95519.qmail@web60505.mail.yahoo.com>
References: <20041201174010.95519.qmail@web60505.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101936835.30819.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Dec 2004 21:33:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-12-01 at 17:40, K G wrote:
> I've recently switched from an "ASUS P4T533-C"
> motherboard to an "ABIT IS7-E2", and got the errors
> mentioned above after boot. Only the motherboard and
> the ram was changed (rambus -> INFINEON 400Mhz DDR).

Those generally indicate bad interrupt routing but could given the other
information you provide just indicate a dud board.

> got the same error(SourceMage linux). Interestingly
> UHU-Linux hasn't got any errors(maybe because the 2.4
  kernel it uses).

Try booting with the option "acpi=off"

> So I've figured that the IRQ is shared between the two
> onboard 1.1 USB hubs and the vga card. My vga is an
> NVIDIA  GeForce4 Ti4200 btw.

Thats fine in itself well assuming the Nvidia driver is being polite
which I would imagine it is. Its binary only so we can only hope not
check.

> Oh, and when I tried to install windows XP for my sis
> on the same computer it hangs after it copied the
> files to hdd, and rebooted the system. It stays there

Sounds like a dud board then ? We see a lot of broken interrupt routing
reports but they usually work on Windows XP by chance and that was all
the vendor tested.

