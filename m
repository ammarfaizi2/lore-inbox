Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287596AbSAHUFN>; Tue, 8 Jan 2002 15:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287571AbSAHUFD>; Tue, 8 Jan 2002 15:05:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:262 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287509AbSAHUEs>; Tue, 8 Jan 2002 15:04:48 -0500
Subject: Re: 2.2.21pre2 oops
To: vherva@niksula.hut.fi (Ville Herva)
Date: Tue, 8 Jan 2002 20:16:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20020108215818.J1331@niksula.cs.hut.fi> from "Ville Herva" at Jan 08, 2002 09:58:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16O2fD-0007Vn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> essentially cat /dev/md0 > /dev/null kind of test to stress the Via KT133
> pci transfers.
> 
> Rootfs is on ide cdrom, the harddrives had no fs on them.
> 
> ksymoops 0.7c on i686 2.2.21pre2-ide+e2compr+raid.  Options
> used

Can you repeat the test to make sure its replicable, then repeat it again
after disabling the new VIA fixups in pci/quirks.c
