Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269039AbUJFNjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269039AbUJFNjn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269153AbUJFNjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:39:43 -0400
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.85]:64820 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S269039AbUJFNjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:39:37 -0400
Date: Wed, 06 Oct 2004 09:38:20 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
 VIA SATA))
In-reply-to: <20041005231642.55308f99.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, andrea@novell.com,
       nickpiggin@yahoo.com.au, rml@novell.com, roland@topspin.com,
       linux-kernel@vger.kernel.org
Message-id: <200410060938.30152.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <52is9or78f.fsf_-_@topspin.com> <41638AEB.5080703@pobox.com>
 <20041005231642.55308f99.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 06 October 2004 02:16, Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> > If your implied answer is true, then we wouldn't need
> > preempt_{en,dis}able() sprinkled throughout the code so much.
>
> Where?
>
> It's less than I expected, actually.

Same here. Did you take into account things like rcu_read_lock()?

Jeff Sipek.

- -- 
Don't drink and derive. Alcohol and algebra don't mix.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBY/VQwFP0+seVj/4RAnCzAKCovAcfr8TFLzQ0xkjPnNtXm7UlygCggWtO
76FhTdx4AvYlBy1qNmR9G3I=
=JKNi
-----END PGP SIGNATURE-----
