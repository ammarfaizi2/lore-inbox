Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131476AbRC0SW2>; Tue, 27 Mar 2001 13:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131477AbRC0SWT>; Tue, 27 Mar 2001 13:22:19 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:432 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131476AbRC0SWM>; Tue, 27 Mar 2001 13:22:12 -0500
Date: Tue, 27 Mar 2001 19:21:23 +0100
From: Tim Waugh <twaugh@redhat.com>
To: TimO <hairballmt@mcn.net>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Will Newton <will@misconception.org.uk>,
        Mike Galbraith <mikeg@wen-online.de>, linux-kernel@vger.kernel.org
Subject: Re: VIA audio and parport in 2.4.2
Message-ID: <20010327192123.L21068@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0103211333440.1541-100000@dogfox.localdomain> <3AB8B877.D36E8719@mandrakesoft.com> <20010321144907.D1323@redhat.com> <3AB9664B.10451E6D@mcn.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="rmUrFcWP4LYae1gV"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AB9664B.10451E6D@mcn.net>; from hairballmt@mcn.net on Wed, Mar 21, 2001 at 07:41:15PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rmUrFcWP4LYae1gV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 21, 2001 at 07:41:15PM -0700, TimO wrote:

> 0x378: possible IRQ conflict!       [Don't know why it always reports
> this]

I've been sending Linus a patch to remove this bogus warning for the
last few pre-patches.

> 0x378: ECP settings irq=<none or set by other means> dma=<none or set by
> other means>
[...]
> With no options in modules.conf, lp0 uses polling; with irq=auto
> dma=auto
> it uses interrupt-driven but no dma?.

It does its best to figure out the IRQ, even though the chipset won't
tell us.  For the DMA channel, it doesn't even try to guess.

Tim.
*/

--rmUrFcWP4LYae1gV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6wNojONXnILZ4yVIRAsuRAJ92XvdiPh8gFM/brIscn0I2XuKWVgCfXDim
0GCYwXaqRiuKH1BcZPvz4sk=
=4XtZ
-----END PGP SIGNATURE-----

--rmUrFcWP4LYae1gV--
