Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162492AbWLBV12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162492AbWLBV12 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 16:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162494AbWLBV12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 16:27:28 -0500
Received: from mx27.mail.ru ([194.67.23.64]:32857 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S1162492AbWLBV11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 16:27:27 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.19: ALi M5229 - CD-ROM not found with pata_ali
Date: Sun, 3 Dec 2006 00:27:22 +0300
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200606220004.30863.arvidjaar@mail.ru> <200612012335.29179.arvidjaar@mail.ru> <20061201215700.34d1e1ff@localhost.localdomain>
In-Reply-To: <20061201215700.34d1e1ff@localhost.localdomain>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612030027.23373.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 02 December 2006 00:57, Alan wrote:
> > Still the same in 2.6.19 + suspend pata_ali patch. The only way I can get
> > CD-ROM is with
> >
> > options pata_ali atapi_max_xfer_mask=0x7f
>
> And I've still got no idea why. Having studied the docs, the old and new
> drivers and a lot more I see no difference to explain it.
>

Irrespectively - why libata does not fall back to PIO when DMA failed? This at 
least would have given working device (even somewhat degraded perfrormance).

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD4DBQFFce+7R6LMutpd94wRAqC6AKDR6zjJ+WDTT6S/7DEOtqGlZ3UgUQCY5tgY
6w8LI78xoTsFDc6sO5vs0A==
=tMFh
-----END PGP SIGNATURE-----
