Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265983AbUA1RSg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 12:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265985AbUA1RSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 12:18:36 -0500
Received: from [207.111.197.98] ([207.111.197.98]:1544 "EHLO www.igotu.com")
	by vger.kernel.org with ESMTP id S265983AbUA1RSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 12:18:32 -0500
From: "Martin Bogomolni" <martinb@www.igotu.com>
To: linux-kernel@vger.kernel.org
Reply-To: martinb@igotu.com
Subject: Re: [linux-usb-devel] Re: USB hangs
Date: Wed, 28 Jan 2004 11:50:31 -0500
Message-Id: <20040128162505.M6816@www.igotu.com>
X-Mailer: Open WebMail 2.21 20031110
X-OriginatingIP: 12.100.203.195 (martinb)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1
 
On Mon 12 Jan, Oliver Neukum wrote:
 
[...]
 
ChangeSet@1.1218, 2004-01-12 00:26:13+01:00, oliver@vermuden.neukum.org -
avoid GFP_KERNEL in block IO path
 
[...]
 
Oliver, Alan, et. al.
 
I applied Oliver & Alan Cox's patches to the 2.4.24 kernel, and am still
seeing hangs when copying large amounts of data over USB on IBM systems
containing two EHCI controllers (Intel 82801EB).
 
I see similar errors to the ones Lucas Postupa had in the kernel logs :
 
Buffer I/O error on device sda1, logical block 134522 lost page write due to
I/O error on sda1
 
Unloading the EHCI driver, and reverting to 1.1 speeds, does not solve the issue.
 
- -Martin

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
 
iD8DBQFAF+7vgZQNxll+EIcRAtkKAJ476IhZ+fLcyj73mDjNptU3rWmQ/ACeIIpz
M5S8ast+WlfEHhKrbAtuPg0=
=NH9l
-----END PGP SIGNATURE-----


