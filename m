Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312517AbSCUVzL>; Thu, 21 Mar 2002 16:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312516AbSCUVzB>; Thu, 21 Mar 2002 16:55:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64271 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312517AbSCUVys>; Thu, 21 Mar 2002 16:54:48 -0500
Subject: Re: SMP IRQ management issues in 2.4.x
To: Fionn.Behrens@unix-ag.org (Fionn Behrens)
Date: Thu, 21 Mar 2002 22:10:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20020321223824.62fb6f21.fionn@unix-ag.org> from "Fionn Behrens" at Mar 21, 2002 10:38:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16oAlY-0006Qc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Can you post both 2.2 and 2.4 tables for comparison
> I am afraid this will get slightly problematic since I upgraded several system components (LVM update and some ext2->ext3 partition changes amongst others) which would probably make booting back into a working 2.2 system a rather adventurous task.
> I think I'll try to do it tomorrow, however. Hope nothing gets broken.

Don't worry about it then - that was mostly to get a feel for things.

> Mar 21 09:56:41 localhost kernel: hde: write_intr: status=0xd0 { Busy }
> Mar 21 09:56:41 localhost kernel: ide2: reset: success
> Mar 21 09:56:41 localhost kernel: hde: status error: status=0x58 { DriveReady                                                     SeekComplete DataRequest }

That doesnt look like an interrupt problem to be honest. Perhaps nvdriver
is triggering something else

(the Busy is the drive saying its still waiting for something)

