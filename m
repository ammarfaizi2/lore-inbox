Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263437AbRFKGaL>; Mon, 11 Jun 2001 02:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263441AbRFKGaB>; Mon, 11 Jun 2001 02:30:01 -0400
Received: from nalserver.nal.go.jp ([202.26.95.66]:62643 "EHLO
	nalserver.nal.go.jp") by vger.kernel.org with ESMTP
	id <S263437AbRFKG3u>; Mon, 11 Jun 2001 02:29:50 -0400
Date: Mon, 11 Jun 2001 15:28:58 +0900 (JST)
From: Aron Lentsch <lentsch@nal.go.jp>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: IRQ problems on new Toshiba Libretto
In-Reply-To: <3B2439E5.493B0472@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0106111228360.1065-100000@triton.nal.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jeff,

The latest version of my kernel '.config' file is
at the end of the file:
http://launchers.tripod.com/linux/libretto_logs_n_kernelconfig.txt

> Suggestions:
> * Build kernel with CONFIG_PCI_GOANY config option.

Originally CONFIG_PCI_GOANY was set by default. I tried
to unset and I have set it again as you suggest, but
there seems to be no difference in dmesg and dump_irq.

> * Go through BIOS setup.  Check for and enable "PNP
> OS" setting, and similar settings which reflect an
> automatically assignment of machine resources.

The problem is that there is no documented way to enter
a BIOS setup for this machine. Settings such as the
boot sequence are done from a Windows application :-(
I will try to ask Toshiba if there are any undocumented
possibilities - but it would be a surprise.

Thanks & Cheers!
Aron

