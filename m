Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUCaTmW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 14:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUCaTmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 14:42:22 -0500
Received: from laibach.mweb.co.za ([196.2.53.177]:28606 "EHLO
	laibach.mweb.co.za") by vger.kernel.org with ESMTP id S262381AbUCaTmU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 14:42:20 -0500
Date: Wed, 31 Mar 2004 21:43:28 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: linux-kernel@vger.kernel.org
Subject: Re: rmmod uhci-hcd hangs eternally (linux-2.6.5-rc2-bk8)
Message-Id: <20040331214328.04b35eda@bongani>
In-Reply-To: <20040331092542.GD28109@charite.de>
References: <20040331092542.GD28109@charite.de>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__31_Mar_2004_21_43_28_+0200_TpE1wdTxY3AeH1oE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__31_Mar_2004_21_43_28_+0200_TpE1wdTxY3AeH1oE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 31 Mar 2004 11:25:42 +0200
Ralf Hildebrandt <Ralf.Hildebrandt@charite.de> wrote:

> Hi!
> 
> When using linux-2.6.5-rc2-bk8, "rmmod uhci-hcd" hangs forever. Even
> when trying a reboot, the machine won't reboot.
> 
> This happens with linux-2.6.5-rc2-bk8 on this hardware:
> 

The same happens on 2.6.5-rc2-mm4, when I rmmod bttv it hangs, id did a cat /proc/<pid>/wchan and found that it was on 12c_release (exiting WindowMaker caused a hard-lock on my PC)

--Signature=_Wed__31_Mar_2004_21_43_28_+0200_TpE1wdTxY3AeH1oE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAax9n+pvEqv8+FEMRAofMAJ4hlqCC5GIoGO9pMx7EkHFx2VVfzQCdEW3l
SoDW4M6qQZ9duaQdbVUAAiU=
=R8py
-----END PGP SIGNATURE-----

--Signature=_Wed__31_Mar_2004_21_43_28_+0200_TpE1wdTxY3AeH1oE--
