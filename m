Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292888AbSCJIzz>; Sun, 10 Mar 2002 03:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292915AbSCJIzp>; Sun, 10 Mar 2002 03:55:45 -0500
Received: from mail.scram.de ([195.226.127.117]:37099 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S292888AbSCJIzk>;
	Sun, 10 Mar 2002 03:55:40 -0500
Date: Sun, 10 Mar 2002 09:55:29 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@alpha.bocc.de
To: Kai Engert <kai.engert@gmx.de>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] Missing module for ISDN / AVM PCMCIA card
In-Reply-To: <21752.1015727511@www61.gmx.net>
Message-ID: <Pine.LNX.4.43.0203100949470.14532-100000@alpha.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai,

> The patch was attached to a message available at:
>   http://uwsg.iu.edu/hypermail/linux/kernel/0103.1/0957.html
> 
> I think, this patch is based on a work described at:
>   http://www.wimmer-net.de/avm-pcmcia/
> (looks outdated, patches there did not help me)
> 
> Cheers,
> Kai
> 
> (Please note that Red Hat seems to have modified that patch a little, the
> file included in their kernel 2.4.9-31 has 3 lines changed.

This might be the bug fix Kai Germaschewski added to my patch:

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0106.1/0805.html

For current 2.4.x kernels, you also need to add the line:

MODULE_LICENSE("GPL");

Cheers,
Jochen


