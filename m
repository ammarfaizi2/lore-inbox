Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269512AbTCDSoB>; Tue, 4 Mar 2003 13:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269503AbTCDSoB>; Tue, 4 Mar 2003 13:44:01 -0500
Received: from palrel11.hp.com ([156.153.255.246]:11928 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id <S269512AbTCDSn7>;
	Tue, 4 Mar 2003 13:43:59 -0500
Date: Tue, 4 Mar 2003 10:54:28 -0800
To: Patrick Mochel <mochel@osdl.org>
Cc: Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       mika.penttila@kolumbus.fi
Subject: Re: [PATCH] pcmcia: get initialization ordering right [Was: [PATCH 2.5] : i82365 & platform_bus_type]
Message-ID: <20030304185428.GA16945@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030304171640.GA16366@bougret.hpl.hp.com> <Pine.LNX.4.33.0303041123210.992-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303041123210.992-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 11:48:22AM -0600, Patrick Mochel wrote:
> 
> Surely you're sore that your code has required some modifications since
> Dominik has started working on PCMCIA, and I'm sure that no harm was
> intended. It's had some bumps, but IMO, he's done a great job, and the 
> result is a vast improvement. The least you could is give the guy some 
> slack, instead of whining about your own inconveniences. 

	I don't mind the changes, changes are usually good. In 2.5.X,
I had to change my code to accomodate the new PCI interface, the
removal of global IRQ, the new module interface, the various USB API
changes and other changes. And actually, your work currently hasn't
had any impact on the source code I follow (yet).
	What I mind is the lack of basic testing. From your patch, the
initialisation order mixup and the other obvious bug fix I sent you,
this code had zero chances of working at all and it's obvious that
nobody bothered to check if it could work or not for at least two
kernel releases.
	Yeah, I know that I should not complain because at least the
code did compile (modulo other minor obvious fixes that are already in
Linus BK).

> Thanks,
> 
> 	-pat

	Have fun...

	Jean
