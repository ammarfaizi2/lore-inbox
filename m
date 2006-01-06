Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWAFOQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWAFOQf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 09:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWAFOQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 09:16:35 -0500
Received: from mx6.mail.ru ([194.67.23.26]:65031 "EHLO mx6.mail.ru")
	by vger.kernel.org with ESMTP id S1750816AbWAFOQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 09:16:35 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: swsusp vs. modular IDE (or wherever your swap is)
Date: Fri, 6 Jan 2006 17:16:30 +0300
User-Agent: KMail/1.9.1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601061716.31410.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Do I understand correctly that swsusp requires drivers for primary swap to be 
compiled in kernel? It appears that initrd-based implementation is possible 
(load drivers for resume partition and then attempt to do manual resume via 
"echo x:y > /sys/power/resume") - are there any issues associated with it?

TIA

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDvnu/R6LMutpd94wRAveZAKC9Vz5a7My6zphTjCeXcelrTcQQOwCfWM1Q
8v/z+GMDfYuSj6sgZGghCKI=
=8+Hb
-----END PGP SIGNATURE-----
