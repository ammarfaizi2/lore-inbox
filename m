Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbTFGA6H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTFGA6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:58:07 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40340
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262445AbTFGA6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:58:04 -0400
Subject: Re: siI3112 crash on enabling dma
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: apeeters@lashout.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1054929160.1793.121.camel@localhost>
References: <1054929160.1793.121.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054948154.17185.45.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jun 2003 02:09:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-06 at 20:52, Adriaan Peeters wrote:
> I tried 2.4.21-rc7-ac1 too, but the dma isn't enabled by default either.

That suprises me somewhat. 7-ac1 should force DMA on

> hda: Maxtor 6Y080M0, ATA DISK drive
> hda: DMA disabled
> hdc: Maxtor 6Y080M0, ATA DISK drive
> hdc: DMA disabled

These are Maxtor drives with SATA convertors ? If so make sure the
convertor is set for UDMA100 not UDMA133 mode. (See www.siimage.com
support pages)

Can you send me a dmesg from 7ac1 please

