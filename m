Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVL3Qrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVL3Qrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 11:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbVL3Qrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 11:47:55 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:18361 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S964845AbVL3Qry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 11:47:54 -0500
Date: Fri, 30 Dec 2005 17:47:52 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Mark v Wolher <trilight@ns666.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
Message-ID: <20051230164751.GQ3105@vanheusden.com>
References: <43B53EAB.3070800@ns666.com>
	<9a8748490512300627w26569c06ndd4af05a8d6d73b6@mail.gmail.com>
	<43B557D7.6090005@ns666.com> <43B5623D.7080402@ns666.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <43B5623D.7080402@ns666.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Sat Dec 31 00:50:14 CET 2005
X-Message-Flag: MultiTail - tail on steroids
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> I'm not sure what to make of this, but it looks like only 1 cpu is kept
> busy with interrupts:
>            CPU0       CPU1       CPU2       CPU3
>   0:    1033372          0          0          0    IO-APIC-edge  timer

Install the 'irqbalance' package.


Folkert van Heusden

- -- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
- ----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
- ----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iIMEARECAEMFAkO1ZLc8Gmh0dHA6Ly93d3cudmFuaGV1c2Rlbi5jb20vZGF0YS1z
aWduaW5nLXdpdGgtcGdwLXBvbGljeS5odG1sAAoJEDAZDowfKNiu5fQAnjADr74k
mv3NRwMfK/FEksDN23/mAJ9RVa4g9EBCPp8ax6EjXXRbXf9ayw==
=v050
-----END PGP SIGNATURE-----
