Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310912AbSCPWJy>; Sat, 16 Mar 2002 17:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310940AbSCPWJo>; Sat, 16 Mar 2002 17:09:44 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47403 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S310912AbSCPWJ1>; Sat, 16 Mar 2002 17:09:27 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        torvalds@transmeta.com (Linus Torvalds),
        andersg@0x63.nu (Anders Gustafsson), arjanv@redhat.com,
        linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] devexit fixes in i82092.c
In-Reply-To: <E16mLHd-00079Z-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Mar 2002 15:03:26 -0700
In-Reply-To: <E16mLHd-00079Z-00@the-village.bc.nu>
Message-ID: <m1hengxj9t.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > Please for the Linux booting Linux scenario it is mandatory we get this right
> > for reboot.  I know for a fact that currently we leave active receive buffers
> on
> 
> > network cards when we reboot. (If you haven't downed the interface).  So it
> > is possible for a network packet to come in and hose a machine that is
> rebooting.
> 
> 
> Thats a bios bug. Its pretty much the whole reason for having bus master
> enable bits in the PCI configuration. The BIOS should have killed the bus
> masters.

In the general reboot case yes it is a BIOS bug.  In the general Linux
booting Linux case there is no BIOS involved.

Eric
