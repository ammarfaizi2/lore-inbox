Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268999AbUJKOUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268999AbUJKOUk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268993AbUJKOUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:20:40 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:25281 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269008AbUJKOUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:20:30 -0400
Subject: Re: 2.6.9-rc4-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <416A7CC8.6040500@kolivas.org>
References: <20041011032502.299dc88d.akpm@osdl.org>
	 <416A7CC8.6040500@kolivas.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097500655.31264.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 11 Oct 2004 14:17:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-10-11 at 13:30, Con Kolivas wrote:
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/
> 
> I have a keyboard problem from 2 things that seem related:
> 
> mm1 dmesg:
> ---
> ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
> i8042.c: Can't read CTR while initializing i8042.

Intel E7xxx board ? If so you either need the patch I posted ages ago
(or grab it from a Fedora kernel) or to turn off USB legacy in the BIOS.

Alan 

