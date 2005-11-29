Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbVK2JIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbVK2JIk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 04:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbVK2JIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 04:08:40 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:58089 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1750932AbVK2JIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 04:08:39 -0500
Date: Tue, 29 Nov 2005 10:08:53 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nvidia fb flicker
Message-ID: <20051129090853.GA7422@stiffy.osknowledge.org>
References: <Pine.LNX.4.64.0511252358390.25302@rtlab.med.cornell.edu> <20051128103554.GA7071@stiffy.osknowledge.org> <1drow6iat7zy8.2rt89nl7eodg.dlg@40tude.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1drow6iat7zy8.2rt89nl7eodg.dlg@40tude.net>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Giuseppe Bilotta <bilotta78@hotpop.com> [2005-11-28 20:57:57 +0100]:

> On Mon, 28 Nov 2005 11:35:54 +0100, Marc Koschewski wrote:
> 
> > * Calin A. Culianu <calin@ajvar.org> [2005-11-26 00:02:46 -0500]:
> > 
> >> [12 quoted lines suppressed]
> > 
> > Hi all,
> > 
> > yesterday I compiled a 2.6.15-rc2 on one of my Inspirons (NVIDIA GeForce2 Go)
> > with nvidiafb. I just changed the fb to some 1600x1200 mode and thus seems to
> > work (the source states GeForce2 Go is supported and known). However, the
> > letters seems to 'flicker' in some way. Uhm, it's not really flickering, it's
> > more like the sinle dots a letter is made of seem to randomly turn on an off. I
> > one takes a closer look it seems like the whole screen is 'fluent' or something.
> > Does anybody know how to handle that? I didn't specify a video mode, but
> > 'video=vesafb:mtrr:3'. 
> 
> Let me guess ... you have a Dell Inspiron 8200 or some such? You must
> compile nvidiafb without support for DDC.
> 

Yes, I do. ;) Setting CONFIG_FB_NVIDIA_I2C=n made it work. I'll do the patches
stuff now first, before I'm going to disable DDC.

Marc
