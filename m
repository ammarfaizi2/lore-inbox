Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTKYCuw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 21:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTKYCuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 21:50:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:14790 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261928AbTKYCuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 21:50:51 -0500
Date: Mon, 24 Nov 2003 18:49:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: jt@hpl.hp.com
cc: David Hinds <dhinds@sonic.net>, linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
In-Reply-To: <20031125023319.GA3819@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0311241845200.1599@home.osdl.org>
References: <20031124235727.GA2467@bougret.hpl.hp.com> <20031124162628.A32213@sonic.net>
 <20031125004942.GA3002@bougret.hpl.hp.com> <Pine.LNX.4.58.0311241804560.1599@home.osdl.org>
 <20031125023319.GA3819@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Nov 2003, Jean Tourrilhes wrote:
>
> 	Currently, I managed to narrow down to :
> -------------------------------------------------
> PCI: Using IRQ router PIIX [8086/7110] at 0000:00:07.0

Can you do a "dump_pirq"? (Found on http://www.kernelnewbies.org/scripts/
among other places, maybe there are newer versions, David would know).

		Linus
