Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269022AbUJKOes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269022AbUJKOes (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269020AbUJKOdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:33:02 -0400
Received: from smtp09.auna.com ([62.81.186.19]:20983 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S269012AbUJKOa7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:30:59 -0400
Date: Mon, 11 Oct 2004 14:30:56 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-rc4-mm1
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041011032502.299dc88d.akpm@osdl.org>
	<416A7CC8.6040500@kolivas.org>
	<1097500655.31264.15.camel@localhost.localdomain>
In-Reply-To: <1097500655.31264.15.camel@localhost.localdomain> (from
	alan@lxorguk.ukuu.org.uk on Mon Oct 11 15:17:37 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1097505056l.6177l.4l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.11, Alan Cox wrote:
> On Llu, 2004-10-11 at 13:30, Con Kolivas wrote:
> > Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/
> > 
> > I have a keyboard problem from 2 things that seem related:
> > 
> > mm1 dmesg:
> > ---
> > ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
> > i8042.c: Can't read CTR while initializing i8042.
> 
> Intel E7xxx board ? If so you either need the patch I posted ages ago
> (or grab it from a Fedora kernel) or to turn off USB legacy in the BIOS.
> 

My box is not a E7xxx, but a 

00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev 02)

and also have problems with USB legacy active in BIOS (erratic PS2 mouse and
so on...)

Perhaps this helps.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc4-mm1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


