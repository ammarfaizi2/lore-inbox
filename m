Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWF0Mqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWF0Mqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWF0Mqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:46:55 -0400
Received: from mx7.mail.ru ([194.67.23.27]:12575 "EHLO mx7.mail.ru")
	by vger.kernel.org with ESMTP id S932352AbWF0Mqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:46:53 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: lib(p)ata SMART support?
Date: Tue, 27 Jun 2006 16:46:39 +0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200606271555.13330.arvidjaar@mail.ru> <20060627121649.GL3114@harddisk-recovery.com>
In-Reply-To: <20060627121649.GL3114@harddisk-recovery.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606271646.41294.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 27 June 2006 16:16, Erik Mouw wrote:
> On Tue, Jun 27, 2006 at 03:55:12PM +0400, Andrey Borzenkov wrote:
> > Using legacy drivers I can use any SMART tools out there; HDD does
> > support SMART. Running libata + pata_ali, smartctl claims device does not
> > support SMART. This is sort of regression when switching from legacy
> > drivers.
>
> Try smartctl -d ata.
>

Right, it works. thank you. I wonder if it possible to automatically find the 
correct device type?

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEoSiwR6LMutpd94wRAgTwAKC8l0kOgyrSHQ8S8lwhn1S7HRXU+QCfdsw5
HP5fUV3FjibIDzxvIWQJDU0=
=Mjin
-----END PGP SIGNATURE-----
