Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263531AbRFAO1Y>; Fri, 1 Jun 2001 10:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263534AbRFAO1E>; Fri, 1 Jun 2001 10:27:04 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:264 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263531AbRFAO1C>; Fri, 1 Jun 2001 10:27:02 -0400
Subject: Re: 2.4.[35] + Dell Poweredge 8450 + Oops on boot
To: katz@advanced.org (Terry Katz)
Date: Fri, 1 Jun 2001 15:25:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <004d01c0eaa4$6dc81860$21efd3d1@advanced.org> from "Terry Katz" at Jun 01, 2001 10:09:10 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155prL-0000aH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> PnP: PNP BIOS installation structure at 0xc00f68f0
> PnP: PNP BIOS version 1.0, entry at f0000:a611, dseg at 400 Unable to
> handle kernel paging request at virtual address 0000ff48  printing eip:
> 00003c9c *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0068:[<00003c9c>]

Your Pnp BIOS crahsed somewhere in the BIOS when we called it - Disable PnP
bios support or get a bios update
