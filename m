Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUITJEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUITJEH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 05:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUITJEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 05:04:07 -0400
Received: from imap.gmx.net ([213.165.64.20]:29420 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266163AbUITJEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 05:04:04 -0400
X-Authenticated: #4512188
Message-ID: <414E9E4F.5050400@gmx.de>
Date: Mon, 20 Sep 2004 11:09:35 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040915)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: "Hoogervorst, J.W." <J.W.Hoogervorst@uva.nl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with sata_sil driver
References: <D6BC5FEAAD77B042A0538B278CDDD26A020D9F7A@pannekoek.uva.nl>
In-Reply-To: <D6BC5FEAAD77B042A0538B278CDDD26A020D9F7A@pannekoek.uva.nl>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hoogervorst, J.W. schrieb:
| Hello,
|
| When using the sata_sil driver, my system locks up. This is regardless
| of
| acpi and apic settings (tried all combinations of these two - without
| any
| luck). All works ok when I use the siimage driver. See below for the
| log.

On my Nforce2 some 2.6.8 broke libata w/ sata_sil in non-Apic mode. With
Apic it worked. Try 2.6.9-rcX kernel. This one worked in both cases.

Prakash
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBTp5PxU2n/+9+t5gRAnT+AKDiMn+EzAiCezGw2FUee+NxXNH+gwCg8npR
fEBsx8+pQ5HWq2jiA8E3hsI=
=ETTt
-----END PGP SIGNATURE-----
