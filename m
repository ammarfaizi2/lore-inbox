Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265000AbTIDNhv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 09:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265001AbTIDNhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 09:37:50 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:21132 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S265000AbTIDNhs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 09:37:48 -0400
Date: Thu, 4 Sep 2003 10:44:59 -0400
From: "Bruno T. Moura" <bruno.tavares@terra.com.br>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm5
Message-Id: <20030904104459.4099da09.bruno.tavares@terra.com.br>
In-Reply-To: <20030904102918.1bd354e1.bruno.tavares@terra.com.br>
References: <20030902231812.03fae13f.akpm@osdl.org>
	<20030904102918.1bd354e1.bruno.tavares@terra.com.br>
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.cSRPl.qow(6?9W"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.cSRPl.qow(6?9W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2003 10:29:18 -0400
"Bruno T. Moura" <bruno.tavares@terra.com.br> wrote:

> On Tue, 2 Sep 2003 23:18:12 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm5/
> > 
> > . Dropped out Con's CPU scheduler work, added Nick's.  This is to help us
> >   in evaluating the stability, efficacy and relative performance of Nick's
> >   work.
> > 
>  [ snip. ]
> 
> Getting this one when setting dma on a barracuda SATA ST380013AS, i875 chipset.
> 
> Sep  4 09:53:26 pyro kernel: hde: set_drive_speed_status: status=0xd0 { Busy }
> Sep  4 09:53:26 pyro kernel: hde: channel busy
> Sep  4 09:53:26 pyro kernel: hde: Speed warnings UDMA 3/4/5 is not functional.
> Sep  4 09:53:26 pyro kernel: hde: dma_timer_expiry: dma status == 0x20
> Sep  4 09:53:26 pyro kernel: hde: DMA timeout retry
> Sep  4 09:53:26 pyro kernel: hde: timeout waiting for DMA
> Sep  4 09:53:26 pyro kernel: hde: status timeout: status=0xd0 { Busy }
> Sep  4 09:53:26 pyro kernel:
> Sep  4 09:53:26 pyro kernel: hde: drive not ready for command
> Sep  4 09:53:26 pyro kernel: hde: status timeout: status=0xd0 { Busy }
> Sep  4 09:53:26 pyro kernel:
> Sep  4 09:53:26 pyro kernel: hde: drive not ready for command
> 

forgot this log part :

Sep  4 09:53:26 pyro kernel: ide2: reset: success
Sep  4 09:53:26 pyro kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Sep  4 09:53:26 pyro kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
Sep  4 09:53:26 pyro kernel: blk: queue 41d72600, I/O limit 4095Mb (mask 0xffffffff)



--=.cSRPl.qow(6?9W
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/V0/rju/SWHCnCQsRAlARAJ4h7sCtZODRCim9gcI98rSH+pIcSQCgk48n
e4jsxwFcbD4d68rXUEfE8yI=
=mupd
-----END PGP SIGNATURE-----

--=.cSRPl.qow(6?9W--
