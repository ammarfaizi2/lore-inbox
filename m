Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278469AbRJOWly>; Mon, 15 Oct 2001 18:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278466AbRJOWlo>; Mon, 15 Oct 2001 18:41:44 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11015 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278469AbRJOWla>; Mon, 15 Oct 2001 18:41:30 -0400
Subject: Re: Status of ServerWorks UDMA
To: jamagallon@able.es (J . A . Magallon)
Date: Mon, 15 Oct 2001 23:48:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Lista Linux-Kernel)
In-Reply-To: <20011016003812.A28638@werewolf.able.es> from "J . A . Magallon" at Oct 16, 2001 12:38:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15tGWg-0003fP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have just installed a system with kernel 2.4.20, and it stops booting
> with a message like:
> 
> 	Controller is in an impossible state. Disable UDMA.

That is triggered when we see a case that can cause disk corruption.

> Board is a SuperMicro 370DLE (SW LE chipset). I have tried disabling 
> ide channels on the bios, but kernel still sees them. I have tried to

At some point I'll sort this properly if Andre doesnt do it first.

> boot with ide0=nodma (is this options real, or I just have invented it ??)
> No solution.

ide=nodma

Please send me details on the system. lspci -v output too.
