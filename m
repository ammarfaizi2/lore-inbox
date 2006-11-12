Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932887AbWKLMqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932887AbWKLMqt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 07:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932888AbWKLMqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 07:46:49 -0500
Received: from mx1.mail.ru ([194.67.23.121]:39458 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S932887AbWKLMqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 07:46:48 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Date: Sun, 12 Nov 2006 15:46:45 +0300
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200611121436.46436.arvidjaar@mail.ru> <200611121326.12309.rjw@sisk.pl>
In-Reply-To: <200611121326.12309.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611121546.46013.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 12 November 2006 15:26, Rafael J. Wysocki wrote:
> Hi,
>
> On Sunday, 12 November 2006 12:36, Andrey Borzenkov wrote:
> > This is rather funny; in 2.6.19-rc5 grub is *really* slow loading kernel
> > when I switch on the system after suspend to disk. Actually, after kernel
> > has been loaded, the whole resuming (up to the point I have usable
> > desktop again) takes about three time less than the process of loading
> > kernel + initrd. During loading disk LED is constantly lit. This almost
> > looks like kernel leaves HDD in some strange state, although I always
> > assumed HDD/IDE is completely reinitialized in this case.
>
> Can you please see what's in the /sys/power/disk file?
>

{pts/0}% cat /sys/power/disk
shutdown

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFVxe1R6LMutpd94wRAgJvAKCMszsHKt2e7uN4h5SHBj7rixFTWgCffGis
2prTVMIdmr6ny1ORFTjO0GQ=
=sZ2j
-----END PGP SIGNATURE-----
