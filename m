Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317201AbSEXQDL>; Fri, 24 May 2002 12:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314457AbSEXQCN>; Fri, 24 May 2002 12:02:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11789 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317191AbSEXP7X>; Fri, 24 May 2002 11:59:23 -0400
Subject: Re: Quota patches
To: hch@infradead.org (Christoph Hellwig)
Date: Fri, 24 May 2002 17:18:21 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        dalecki@evision-ventures.com (Martin Dalecki), jack@suse.cz (Jan Kara),
        nathans@sgi.com (Nathan Scott),
        torvalds@transmeta.com (Linus Torvalds),
        hirofumi@mail.parknet.co.jp (OGAWA Hirofumi),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020524165514.A20631@infradead.org> from "Christoph Hellwig" at May 24, 2002 04:55:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BHll-0006nB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For 2.5 I have some plans to make obsolete syscalls depend on CONFIG_COMPAT_*,
> this allows to compile big and bloated kernel for compatiblity and smaller
> kernels without that (e.g. for embedded devices).  And in fact we have quite
> a loft of cruft that can go away for setups only having very modern userspace..

I'm sure we do. For embedded you also want config options to remove the 
block layer and so forth. I'd been thinking about a set of options buried
in a config menu item like "Fine tune configuration for small/embedded devices" CONFIG_SMALL 

