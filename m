Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277798AbRJWPnz>; Tue, 23 Oct 2001 11:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277792AbRJWPnp>; Tue, 23 Oct 2001 11:43:45 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61701 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277785AbRJWPni>; Tue, 23 Oct 2001 11:43:38 -0400
Subject: Re: Fail to compile 2.4.13-pre6 (with ext3fs) with gcc-3.0
To: kilobug@freesurf.fr (Kilobug)
Date: Tue, 23 Oct 2001 16:50:44 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (lkm)
In-Reply-To: <3BD588F5.7020301@freesurf.fr> from "Kilobug" at Oct 23, 2001 05:12:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15w3pE-0006BQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=athlon     -c -o 8139too.o 8139too.c
> 8139too.c: In function `netdev_ethtool_ioctl':
> 8139too.c:2432: Unrecognizable insn:
> (insn/i 618 1061 1058 (parallel[

gcc 3.0 isnt an appropriate compiler for the kernel right now. Do let
the gcc development team know about the problem though
