Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266576AbSLDNxs>; Wed, 4 Dec 2002 08:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266643AbSLDNxs>; Wed, 4 Dec 2002 08:53:48 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:20133 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266576AbSLDNxr>; Wed, 4 Dec 2002 08:53:47 -0500
Subject: Re: [IDE-PATCH] Add piix fix up function into pii.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: hugang <hugang@soulinfo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021204211055.185221c0.hugang@soulinfo.com>
References: <20021204211055.185221c0.hugang@soulinfo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 14:35:39 +0000
Message-Id: <1039012539.15359.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-04 at 13:10, hugang wrote:
> Hello all:
> 
> Please apply.
> Index: drivers/ide//pci/piix.c

Please tell me why it would be needed ?

pci_enable_device already ensures the resources are allocated. Also on a
PIIX you only need BAR4 as the other bits are on the ISA side.

Alan

