Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVBKXxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVBKXxJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 18:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVBKXxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 18:53:08 -0500
Received: from mail.tc-exe.ru ([83.102.151.157]:35069 "EHLO mail.nkosino.ru")
	by vger.kernel.org with ESMTP id S262254AbVBKXxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 18:53:03 -0500
Message-ID: <420D455D.7050505@kernelpanic.ru>
Date: Sat, 12 Feb 2005 02:53:01 +0300
From: "Boris B. Zhmurov" <bb@kernelpanic.ru>
Reply-To: bb@kernelpanic.ru
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050202 Rulez Forever/1.7.5-5.bbel
X-Accept-Language: en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Barbara Post <b.post@laposte.net>
Subject: Re: ohci_hcd, usb scanner and kernel 2.6.8.1 or 2.6.10 troubles
References: <420D3EEF.20406@laposte.net>
In-Reply-To: <420D3EEF.20406@laposte.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello, Barbara Post.

On 12.02.2005 02:25 you said the following:

| Hi,
| I am unable to use my USB Agfa Snapscan 1212_U scanner, with kernel
| 2.6.8.1 or 2.6.10 (both compiled by myself from www.kernel.org sources)
| and xsane 0.96-1 (Debian).
|
| It worked with kernel 2.6.7.
|
| When I use VMware, I'm able to use it though (in Windows), whatever
| linux kernel I use.
|
| When I start xsane, I get "error opening device
| 'snapscan:libusb:001:004': I/O error on device" or simply "no device
| found" if I restart xsane after the first error message (or sometimes at
| first start).
|
| Sometimes it gets further and when I try to acquire preview, I get "I/O
| error" and the following in /var/log/syslog :
|
| Feb 11 23:19:00 babs1 kernel: ohci_hcd 0000:00:02.2: urb c15e13e0 path
| 1.3 ep1in 82160000 cc 8 --> status -75


I have the same problem with my Epson 1260 on RHEL4 beta2 (linux-2.6.9).
I don't know about 2.6.7, but with 2.4.21 (RHEL3) it works fine.


- --
Boris B. Zhmurov
mailto: bb@kernelpanic.ru
"wget http://kernelpanic.ru/bb_public_key.pgp -O - | gpg --import"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCDUVdmEQixi5w37YRApP+AJ9I5M7hf/0HPCATTnemFaNbLhvsbgCfZdTz
+hQ/jvcu7+xDpaXYTiOFZj4=
=6WVB
-----END PGP SIGNATURE-----
