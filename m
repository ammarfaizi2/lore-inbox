Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293688AbSC0Xsx>; Wed, 27 Mar 2002 18:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293713AbSC0Xsn>; Wed, 27 Mar 2002 18:48:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10247 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293688AbSC0Xs0>; Wed, 27 Mar 2002 18:48:26 -0500
Subject: Re: [bug] 2.4.19-pre4-ac2 hang at boot with ALI15x3 chipset support
To: james.mayer@acm.org (James Mayer)
Date: Thu, 28 Mar 2002 00:04:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020327233812.GA7310@galileo> from "James Mayer" at Mar 27, 2002 04:38:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16qNP7-0006T9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After adding printk calls to alim15x3.c, it seems to hang during the
> pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02) call on line 588.

Does it work if you comemtn that line out ?
