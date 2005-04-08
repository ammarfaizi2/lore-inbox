Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbVDHSJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbVDHSJW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbVDHSJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:09:22 -0400
Received: from vsmtp4.tin.it ([212.216.176.224]:29650 "EHLO vsmtp4.tin.it")
	by vger.kernel.org with ESMTP id S262907AbVDHSJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:09:09 -0400
Message-ID: <4256C89C.4090207@tin.it>
Date: Fri, 08 Apr 2005 13:08:28 -0500
From: "Franco \"Sensei\"" <senseiwa@tin.it>
Reply-To: Sensei <senseiwa@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [INFO] Kernel strict versioning
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4290C8904D482068719B7792"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4290C8904D482068719B7792
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi. I'm new in the list... please excuse me, I'm probably naive.

I'm using linux from 1997, and now I'm wondering why the kernel 
versioning system has been so strict. I've been following the thread 
``RFD: Kernel release numbering'', but still I have some concerns...

Earlier versions used the odd/even numbering, unstable/stable 
versioning. That was quite good from a user's point of view, since it 
carried significant meaning immediately.

The fact that we face a multilevel versioning number, say 
2.6.11-14.4.whatever-2 is quite a pain. I'm saying not that it's a bad 
idea that a product has more versions, my product follow the even/odd 
and subversion numbering. I'm saying that the scripts used in the kernel 
building should be quite smarter.

Actually changing a kernel results in creating a /lib/modules/version 
directory, creating a heavy confusion for a user, especially when 
compiling other modules outside the official kernel release: he juts 
looses the modules and has to recompile them.

I was wondering about the feasibility of handling just a MAJOR.MINOR 
versioning. This would be quite an increment for a user to mantain his 
kernel. Modules can still be loaded and found. We would have a single 
/lib/modules/2.6 being much compatible with other modules, working with 
2.6.x and 2.6.y without any difficulty. Also the source tree from a 
user's point of view is much cleaner, identifying the ongoing kernel 
much easily.

I'm not talking about the developing process, which still uses 2.6.x, 
and it's good as it identifies the current subversion, but there's no 
use in collecting so many other kernels when considering them ``stable''.

I'm just wondering...

-- 
Sensei <mailto:senseiwa@tin.it> <pgp:8998A2DB>
        <icqnum:241572242>
        <yahoo!:sensei_sen>
        <msn-id:sensei_sen@hotmail.com>

--------------enig4290C8904D482068719B7792
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCVsif4LBKhYmYotsRAko/AJwK2BMMVU31FXcrECSduK+iUxb0NACdFNa7
R7xdiWv1viOyAN2ohroS6Nw=
=Au8X
-----END PGP SIGNATURE-----

--------------enig4290C8904D482068719B7792--
