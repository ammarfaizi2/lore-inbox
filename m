Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275068AbRJANjK>; Mon, 1 Oct 2001 09:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275067AbRJANjA>; Mon, 1 Oct 2001 09:39:00 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56588 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275061AbRJANis>; Mon, 1 Oct 2001 09:38:48 -0400
Subject: Re: [PATCH] PnPBIOS 2.4.9-ac1[56] Vaio fix
To: jdthood@home.dhs.org (Thomas Hood)
Date: Mon, 1 Oct 2001 14:44:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011001125401.9684B8BF@thanatos.toad.net> from "Thomas Hood" at Oct 01, 2001 08:54:01 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15o3Mq-0001Kq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Stelian and others:  So the fix works using is_sony_vaio_laptop
> to set the pnp_bios_dont_use_current_config flag.  (Alan can
> shorten this name if he wants ;)  The is_sony_vaio_laptop
> flag is only found in the i386 and x86_64 arches.  Is the
> pnpbios driver used on other arches?  If so then we'll have
> to provide the flag in those arches or pnpbios won't link.
> Alan?

PnPBIOS is a PC specific affliction. Other platforms have more elegantly
designed but even buggier solutions
