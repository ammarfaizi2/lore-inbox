Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315237AbSEFWlG>; Mon, 6 May 2002 18:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315245AbSEFWlF>; Mon, 6 May 2002 18:41:05 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:22277 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315237AbSEFWlF>; Mon, 6 May 2002 18:41:05 -0400
Date: Tue, 7 May 2002 00:40:40 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 55
In-Reply-To: <3CD64844.20907@evision-ventures.com>
Message-ID: <Pine.LNX.4.21.0205070036150.32715-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 6 May 2002, Martin Dalecki wrote:

> - Eliminate CONFIG_BLK_DEV_IDEPCI - it's duplicating the functionality of the
>    already present and fine CONFIG_PCI flag and if we are a PCI host, we are
>    indeed very likely to need host chip support anyway.

Please don't do this! There are configurations possible with pci enabled 
but without a pci ide adapter.

Could you please try to compile without CONFIG_BLK_DEV_IDEDMA_PCI enabled?

bye, Roman

