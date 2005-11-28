Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVK1Kfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVK1Kfp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 05:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVK1Kfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 05:35:45 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:63193 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751161AbVK1Kfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 05:35:45 -0500
Date: Mon, 28 Nov 2005 11:35:54 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: ajoshi@shell.unixbox.com, akpm@osdl.org, adaplas@pol.net,
       linux-kernel@vger.kernel.org, linux-nvidia@lists.surfsouth.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: nvidia fb flicker (was: Re: [PATCH] nvidiafb support for 6600 and 6200)
Message-ID: <20051128103554.GA7071@stiffy.osknowledge.org>
References: <Pine.LNX.4.64.0511252358390.25302@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511252358390.25302@rtlab.med.cornell.edu>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc1-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Calin A. Culianu <calin@ajvar.org> [2005-11-26 00:02:46 -0500]:

> Hi,
> 
> This patch can be applied against 2.6.15-rc1 to add support to the 
> nvidiafb driver for a few obscure (yet on-the-market) nvidia 
> boards/chipsets, including various versions of the Geforce 6600 and 6200.
> 
> This patch has been tested and allows the above-mentioned boards to get 
> framebuffer console support.
> 
> Thanks!
> 
> -Calin

Hi all,

yesterday I compiled a 2.6.15-rc2 on one of my Inspirons (NVIDIA GeForce2 Go)
with nvidiafb. I just changed the fb to some 1600x1200 mode and thus seems to
work (the source states GeForce2 Go is supported and known). However, the
letters seems to 'flicker' in some way. Uhm, it's not really flickering, it's
more like the sinle dots a letter is made of seem to randomly turn on an off. I
one takes a closer look it seems like the whole screen is 'fluent' or something.
Does anybody know how to handle that? I didn't specify a video mode, but
'video=vesafb:mtrr:3'. 

Regards,
	Marc
