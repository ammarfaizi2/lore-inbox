Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVAWTu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVAWTu7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 14:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVAWTu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 14:50:59 -0500
Received: from [213.177.124.17] ([213.177.124.17]:15766 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S261345AbVAWTuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 14:50:54 -0500
Date: Sun, 23 Jan 2005 22:50:10 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Stephen Kitchener <stephen@g6dzj.demon.co.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: System beeper - no sound from mobo's own speaker
Message-Id: <20050123225010.0172a6e0.vsu@altlinux.ru>
In-Reply-To: <200501231937.53099.stephen@g6dzj.demon.co.uk>
References: <200501231937.53099.stephen@g6dzj.demon.co.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__23_Jan_2005_22_50_10_+0300_4T2QV7gyVI8QTfW0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__23_Jan_2005_22_50_10_+0300_4T2QV7gyVI8QTfW0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 23 Jan 2005 19:37:53 +0000 Stephen Kitchener wrote:

> I seem to have a problem that, in that when I am using the kernel supplied 
> with Mandrake 10.0 and 10.1 and also fedora 3, there seems to be a distinct 
> lack of beeps coming from the system, once it is up and running. I am NOT 
> talking about sounds that might be coming from any sound card that might be 
> connected to the system, but the plain old speaker that sits in the PC case.

Does "modprobe pcspkr" help?  In 2.6.x kernels the PC speaker support
can be built as a loadable module; probably the startup scripts do not
load it automatically.

--Signature=_Sun__23_Jan_2005_22_50_10_+0300_4T2QV7gyVI8QTfW0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB8//2W82GfkQfsqIRAtzxAJ0YxnsFKHIfLXeaTpIcpuXGZSURWgCeLpdM
LkqRp9j2vSF+9xYYN1Ddgz4=
=ErZz
-----END PGP SIGNATURE-----

--Signature=_Sun__23_Jan_2005_22_50_10_+0300_4T2QV7gyVI8QTfW0--
