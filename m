Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313421AbSC2KCP>; Fri, 29 Mar 2002 05:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313422AbSC2KCF>; Fri, 29 Mar 2002 05:02:05 -0500
Received: from malasada.lava.net ([64.65.64.17]:22525 "EHLO malasada.lava.net")
	by vger.kernel.org with ESMTP id <S313421AbSC2KBy>;
	Fri, 29 Mar 2002 05:01:54 -0500
Message-Id: <m16qtCc-000wE9C@malasada.lava.net>
Date: Fri, 29 Mar 2002 00:01:46 -1000 (HST)
From: bhoward@hale.org
To: James Mayer <james.mayer@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bug] 2.4.19-pre4-ac2 hang at boot with ALI15x3 chipset support
In-Reply-To: <124088188@toto.iv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James> Good information there.  Oddly enough, I don't need to specify the
James> pci=conf2, though.

Remember that you only need the pci=conf2 to get past the lockup bug
when doing an initial installation from CDROM.  After that, once you
have installed a kernel updated with the patch to alim15x3.c, the need
for it goes away (and in fact, continuing to use pci=conf2 will
actually prevent many of the other devices from being properly
recognized).

					Cheers,
					Bruce
