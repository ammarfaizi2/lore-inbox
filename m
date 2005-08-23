Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbVHWPqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbVHWPqQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 11:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVHWPqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 11:46:16 -0400
Received: from master.altlinux.ru ([62.118.250.235]:29703 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1750960AbVHWPqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 11:46:15 -0400
Date: Tue, 23 Aug 2005 19:45:48 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: "Paul Rolland" <rol@as2917.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.31] - USB device numbering in /proc/bus/usb
Message-Id: <20050823194548.6441d995.vsu@altlinux.ru>
In-Reply-To: <200508231314.j7NDEGD09705@tag.witbe.net>
References: <200508231314.j7NDEGD09705@tag.witbe.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__23_Aug_2005_19_45_48_+0400_9PL976=Tg+a=z_gn"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__23_Aug_2005_19_45_48_+0400_9PL976=Tg+a=z_gn
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 23 Aug 2005 15:14:38 +0200 Paul Rolland wrote:

> I've just rebooted a machine, and the eagle ADSL modem I was using,
> presented as /proc/bus/usb/002/005 in now presented as 
> /proc/bus/usb/002/003 (same bus, but device ID changed from 5 to 3).
> 
> Is this an expected behavior, when running a 2.4.31 kernel ?

Yes.  Addresses for USB devices are assigned dynamically.  If you
disconnect the modem from USB and connect it again, its address will
change.

> I would have been expecting some more stability in the numbering across
> reboot, the same way IDE disks numbers are stable.

Use some other identifier which is stable - e.g., serial number of the
USB device (unfortunately, many devices don't have it).

--Signature=_Tue__23_Aug_2005_19_45_48_+0400_9PL976=Tg+a=z_gn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDC0SvW82GfkQfsqIRAlIwAJ4+sHP7Cot7wzNDDWX/6BJOhR0kRgCfXURc
Xng+Zc4c9Ujm11n3hyNYack=
=XAnz
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Aug_2005_19_45_48_+0400_9PL976=Tg+a=z_gn--
