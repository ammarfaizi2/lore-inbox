Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263230AbTDVPQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 11:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbTDVPQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 11:16:26 -0400
Received: from 217-126-36-165.uc.nombres.ttd.es ([217.126.36.165]:42207 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id S263230AbTDVPQW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 11:16:22 -0400
Date: Tue, 22 Apr 2003 17:28:18 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: cannot boot 2.5.67 
In-Reply-To: <200304171756.h3HHuqb9006030@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.44.0304221722160.1536-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Apr 2003 Valdis.Kletnieks@vt.edu wrote:

> On Thu, 17 Apr 2003 19:46:34 +0200, Mads Christensen <mfc@krycek.org>  said:
> 
> > You have to get
> > CONFIG_INPUT=y, CONFIG_VT=y and CONFIG_VT_CONSOLE=y
> > inorder for you to see anything =)
> 
> OK.. Can we *please* fix the 2.5.68 Kconfig to default these 3 values
> so we don't have to keep saying this?  The embedded people that want
> 'n' or 'm' can type it themselves. ;)

After fixing these parametres (make oldconfig did not set them), I still 
cannot boot 2.5.68. I've tried it with pci=noapci and also with apci=off, 
as the boot message suggestes.

I have a Dell Latitude Laptop with a Xircom Cardbus ethernet + modem card.
If I boot with the card inserted booting stops like this:
........
socket status = 30000006

Even SysRq does not work.

If I remove it I see:
socket status = 30000020
Intel PCIC probe: not found.
Unable to open initial console.
Kernel panic: No init found. Try passing init= option to kernel.

Here SysRq works.

I assume it must be a FAQ but cannot find it.

Pau

