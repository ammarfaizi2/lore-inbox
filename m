Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269387AbRH0WO0>; Mon, 27 Aug 2001 18:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269412AbRH0WOQ>; Mon, 27 Aug 2001 18:14:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51978 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269387AbRH0WN7>; Mon, 27 Aug 2001 18:13:59 -0400
Subject: Re: Bug or feature?
To: jfbeam@bluetopia.net (Ricky Beam)
Date: Mon, 27 Aug 2001 23:17:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mail List)
In-Reply-To: <Pine.GSO.4.33.0108271736500.23852-100000@sweetums.bluetronic.net> from "Ricky Beam" at Aug 27, 2001 06:10:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bUhG-0004sk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   dep_tristate '  Sun Microsystems userflash support' CONFIG_MTD_SUN_UFLASH $CONFIG_SPARC64
> $CONFIG_SPARC64 is null and this doesn't appear to the shell function as an
> arg.  Thus, it's presented as a selectable (tho' not compilable) option.

In -ac these should have been fixed for a while. I'm waiting for David
Woodhouse to send me his official versions of these fixes
