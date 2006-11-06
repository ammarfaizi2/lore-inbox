Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753390AbWKFQeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbWKFQeq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753395AbWKFQeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:34:46 -0500
Received: from mx6.mail.ru ([194.67.23.26]:4994 "EHLO mx6.mail.ru")
	by vger.kernel.org with ESMTP id S1753390AbWKFQep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:34:45 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.18.2: lockdep warnings on rmmod ohci_hcd
Date: Mon, 6 Nov 2006 19:34:58 +0300
User-Agent: KMail/1.9.5
Cc: Arjan van de Ven <arjan@infradead.org>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0611061113140.6579-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0611061113140.6579-100000@iolanthe.rowland.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611061934.59569.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 06 November 2006 19:16, Alan Stern wrote:
> On Mon, 6 Nov 2006, Andrey Borzenkov wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > On Monday 06 November 2006 17:18, Arjan van de Ven wrote:
> > > On Mon, 2006-11-06 at 15:46 +0300, Andrey Borzenkov wrote:
> > > > I presume this is lockdep; this looks initially truncated,
> > > > unfortunately this
> > > > is how it was stored in messages. I will try to get more complete
> > > > output ig
> > > > required.
> > >
> > > the interesting bits are missing unfortunately (the first 10 lines or
> > > so).
> > >
> > > Also this will be in "dmesg" if your system actually survives...
> >
> > well, dmesg had exactly the same contents. Here full dmesg with increased
> > LOG_SHIFT.
>
> I always find it rather difficult to understand the meaning of lockdep
> warnings, but this looks a bug that was fixed in 2.6.19-rc1.  The patch
> that fixed it is here:
>
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=115938807428103&w=2
>

Yes, it has fixed it. Thank you

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFT2QzR6LMutpd94wRAh4OAKCZHqj/W3aFgEiXp3puPLhur5Rb9ACff67R
oIpIdzM5pMypaqCajAbWLW4=
=yHf7
-----END PGP SIGNATURE-----
