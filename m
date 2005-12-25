Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbVLYVBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbVLYVBf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 16:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbVLYVBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 16:01:35 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:24454 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1750921AbVLYVBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 16:01:34 -0500
Date: Sun, 25 Dec 2005 22:01:32 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Marc Singer <elf@buici.com>
Cc: Axel Kittenberger <axel.kittenberger@univie.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: Possible Bootloader Optimization in inflate (get rid of
	unnecessary 32k Window)
Message-ID: <20051225210118.GB1498@vanheusden.com>
References: <200512221352.23393.axel.kernel@kittenberger.net>
	<20051222173704.GB23411@buici.com>
	<1167.81.217.14.229.1135275158.squirrel@webmail.univie.ac.at>
	<20051222183012.GA27353@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222183012.GA27353@buici.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Mon Dec 26 21:20:51 CET 2005
X-Message-Flag: Want to extend your PGP web-of-trust? Coordinate a key-signing
	at www.biglumber.com
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Have you timed this operation?  I would predict that the time to copy
> > > the kernel is nominal as compared the the time taken to perform the
> > > decompression.
> > In the current version it is defleated AND copied. The optimization would
> > reduce it by 1 copy.
> Right.  And the time to perform that one copy is exactly...?
> I doubt that it is a significant percentage of the whole operation.

On the other hand it makes the kernel a few bytes smaller :-)


Folkert van Heusden

-- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
