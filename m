Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbTEPRSb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 13:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbTEPRSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 13:18:31 -0400
Received: from [193.10.185.236] ([193.10.185.236]:4874 "HELO
	smtp.dormnet.his.se") by vger.kernel.org with SMTP id S264498AbTEPRSa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 13:18:30 -0400
Date: Fri, 16 May 2003 19:28:34 +0200
From: Andreas Henriksson <andreas@fjortis.info>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm6
Message-ID: <20030516172834.GA9774@foo>
References: <20030516015407.2768b570.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20030516015407.2768b570.akpm@digeo.com>
X-gpg-key: http://fjortis.info/andreas_henriksson.gpg
X-gpg-fingerprint: C51F 9B43 4390 95BB A22E  16F2 00EF 6094 449E 0434
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi!

I had to remove "static" from the agp_init-function in
drivers/char/agp/backend.c to get the kernel to link (when building
Intel 810 Framebuffer into the kernel).

I also got unresolved symbols for two modules.
arch/i386/kernel/suspend.ko: enable_sep_cpu, default_ldt, init_tss
arch/i386/kernel/apm.ko: save_processor_state, restore_processor_state

Regards,
Andreas Henriksson

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+xR/CAO9glESeBDQRApDYAJ9K8lh2ePhOyHuoxj4A1AEVjoVNpACguI+5
YDr6+BtNJCcHBMu9bMfj1eQ=
=bwlX
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
