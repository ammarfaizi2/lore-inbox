Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbUCOQeE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 11:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbUCOQeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 11:34:04 -0500
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:56714 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S262644AbUCOQd7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 11:33:59 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: post-install /etc/modprobe.conf
Date: Mon, 15 Mar 2004 16:24:43 +0000
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200403151624.44176.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I had the line "post-install emu10k1 /usr/local/etc/emu-script" in my 2.4 
/etc/modules.conf file which would tweak the OSS emu10k1 driver after it got 
loaded.

Moving that line to /etc/modprobe.conf gives me errors - basically the system 
is ignoring the line because its not valid anymore.

What's the preferred way of doing this now?

Cheers,

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAVdjMBn4EFUVUIO0RAi/mAJ0a+KkTC9HXGujt0WZK+Ia4MnlGhgCfUwQZ
HIE3S6Mhkjz75nfbhdmOOOI=
=klM/
-----END PGP SIGNATURE-----

