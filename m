Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLRPDw>; Mon, 18 Dec 2000 10:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLRPDm>; Mon, 18 Dec 2000 10:03:42 -0500
Received: from quechua.inka.de ([212.227.14.2]:21112 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129260AbQLRPDg>;
	Mon, 18 Dec 2000 10:03:36 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: test13-pre3 woes
In-Reply-To: <Pine.LNX.4.30.0012180702380.16423-100000@hafnium.nkbj.dk> <3A3DD010.225F721C@pobox.com> <20001218031912.E3199@cadcamlab.org>
Organization: private Linux site, southern Germany
Date: Mon, 18 Dec 2000 15:27:16 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E1481G2-0006PE-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001218031912.E3199@cadcamlab.org> you write:
> [J Sloan]
> > The module now compiles and gets installed -
> > Unfortunately, attempting to load it does not go well:
> >
> > kernel/drivers/char/drm/tdfx.o: unresolved symbol remap_page_range
>...
> Those symbols are rather generic and rather important.  Sounds like a
> generic module problem.  Do other modules load?  Does your kernel use
> MODVERSIONS?  (This module apparently doesn't.)  Are you using a recent
> version of modutils?

The most important question: Did you run "make dep" after doing the patch?

Olaf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
