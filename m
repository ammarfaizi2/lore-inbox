Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbTDUQWb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 12:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbTDUQWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 12:22:31 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:63721 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261609AbTDUQWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 12:22:30 -0400
Date: Mon, 21 Apr 2003 13:33:04 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre7 - hpt366.c does not build
In-Reply-To: <3E8E5308.5E359463@eyal.emu.id.au>
Message-ID: <Pine.LNX.4.53L.0304211329570.7656@freak.distro.conectiva>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva>
 <3E8E5308.5E359463@eyal.emu.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 Apr 2003, Eyal Lebedinsky wrote:

> hpt366.c: At top level:
> hpt366.c:1289: `PCI_DEVICE_ID_TTI_HPT372N' undeclared here (not in a
> function)
> hpt366.c:1289: initializer element is not constant
> hpt366.c:1289: (near initialization for `hpt366_pci_tbl[5].device')
> make[4]: *** [hpt366.o] Error 1
> make[4]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre/drivers/ide/pci'

Fixed in -BK tree.
