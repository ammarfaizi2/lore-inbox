Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136491AbRD3Q6M>; Mon, 30 Apr 2001 12:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136493AbRD3Q56>; Mon, 30 Apr 2001 12:57:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4617 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136491AbRD3Q5j>; Mon, 30 Apr 2001 12:57:39 -0400
Subject: Re: 2.4.4 Sound corruption [PATCH]
To: c.p.botha@its.tudelft.nl
Date: Mon, 30 Apr 2001 17:58:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com, goemon@anime.net
In-Reply-To: <20010430030626.A7981@dutidad.twi.tudelft.nl> from "Charl P. Botha" at Apr 30, 2001 03:06:26 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uH0V-0008Hk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Attached is a patch to the quirks.c in linux kernel 2.4.4 that fixes the
> sound corruption problem (thanks to Dan Hollis for the info).  Do I have to
> send this anywhere else as well?

It seems very broken

> -	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vialatency },
> +	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_vialatency },

You are hacking the wrong chip..
