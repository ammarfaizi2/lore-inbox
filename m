Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262822AbVAFNps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbVAFNps (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 08:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVAFNpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 08:45:47 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:54970 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262822AbVAFNpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 08:45:46 -0500
Subject: Re: [PATCH] CS461x gameport code isn't being included in build
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org
In-Reply-To: <200501040609.j0469qtl004738@hera.kernel.org>
References: <200501040609.j0469qtl004738@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104940156.24187.186.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 12:41:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-04 at 04:14, Linus Torvalds applied:

> -obj-$(CONFIG_GAMEPORT_CS461X)	+= cs461x.o
> +obj-$(CONFIG_GAMEPORT_CS461x)	+= cs461x.o
>  obj-$(CONFIG_GAMEPORT_EMU10K1)	+= emu10k1-gp.o
>  obj-$(CONFIG_GAMEPORT_FM801)	+= fm801-gp.o
>  obj-$(CONFIG_GAMEPORT_L4)	+= lightning.o

This change makes the CS461x unique in having lower case in the config
name. In the previous discussion on the kernel list this patch was
rejected and instead the 461x was changed to 461X in the Kconfig file
keeping consistency with the rest of the kernel.

Alan

