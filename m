Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311127AbSCPWXP>; Sat, 16 Mar 2002 17:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311166AbSCPWXG>; Sat, 16 Mar 2002 17:23:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49963 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S311127AbSCPWWv>; Sat, 16 Mar 2002 17:22:51 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        torvalds@transmeta.com (Linus Torvalds),
        andersg@0x63.nu (Anders Gustafsson), arjanv@redhat.com,
        linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] devexit fixes in i82092.c
In-Reply-To: <E16mMer-0007Q4-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Mar 2002 15:16:56 -0700
In-Reply-To: <E16mMer-0007Q4-00@the-village.bc.nu>
Message-ID: <m1d6y4xinb.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > In the general reboot case yes it is a BIOS bug.  In the general Linux
> > booting Linux case there is no BIOS involved.
> 
> In that case yes I can see why you want to turn the bus masters off when you
> boot the new kernel

And in the general case I'd like to what rmmod does so that
the device is in a sane state so the Linux driver can handle it.

Very rarely does rmmod leave a device in a state where you cannot
run imsmod.

Eric

