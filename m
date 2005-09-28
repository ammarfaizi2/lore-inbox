Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVI1TvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVI1TvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 15:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVI1TvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 15:51:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:13978 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750733AbVI1TvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 15:51:15 -0400
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Grant Coady <grant_lkml@dodo.com.au>
Subject: Re: [PATCH] pci_ids: remove duplicated and non-referenced symbols
Date: Wed, 28 Sep 2005 21:51:18 +0200
User-Agent: KMail/1.7.2
Cc: Greg KH <gregkh@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509282151.19000.daniel.ritz@gmx.ch>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -2198,16 +1690,10 @@
>  #define PCI_DEVICE_ID_ENE_1211		0x1211
>  #define PCI_DEVICE_ID_ENE_1225		0x1225
>  #define PCI_DEVICE_ID_ENE_1410		0x1410
> -#define PCI_DEVICE_ID_ENE_710		0x1411
> -#define PCI_DEVICE_ID_ENE_712		0x1412
>  #define PCI_DEVICE_ID_ENE_1420		0x1420
> -#define PCI_DEVICE_ID_ENE_720		0x1421
> -#define PCI_DEVICE_ID_ENE_722		0x1422

those are now used in mainline by drivers/pcmcia/yenta_socket.c

rgds
-daniel

