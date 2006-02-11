Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWBKJAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWBKJAW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 04:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWBKJAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 04:00:22 -0500
Received: from mx2.mail.ru ([194.67.23.122]:35407 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1751276AbWBKJAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 04:00:21 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Sat, 11 Feb 2006 11:59:55 +0300
User-Agent: KMail/1.9.1
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602111159.57342.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[Sorry for crippled Cc I'm answering off web archive]

> Joerg Schilling schrieb am 2006-02-09:
> > DervishD <lkml@dervishd.net> wrote:
> > > other half doesn't have it probably has a bad user interface. You
> > > know that if a program uses a naming convention different from ALL
> > > the rest of programs is because the program has a problem. You know
> > > that if the only UNIX program out there that doesn't use /dev entries
> > > to talk to devices is cdrecord, the problem *probably* is in
> > > cdrecord, and not in UNIX...
> >
> > So why do you like to introduce a different naming scheme?
>
> It is striking that Jіrg Schilling's code alone uses this naming scheme,
> and nothing else appears to be. If there is, perhaps naming a few
> typical real-world applications could enlighten us. You haven't
> mentioned examples yet, so there isn't even a faint hint cdrecord is
> consistent with the so-called real-world.

Legato Networker (now belongs to EMC) is using the same enumeration scheme to 
access media changer (but not the drivers themselves). In this case I can 
speak for Solaris, Windows and Linux. I must admit I would have preferred to 
use something like /dev/sgen on Solaris because even Networker documentation 
warns that adapter number that is shown by configuration bears no relation to 
adapter instance numbers as can be seen by user. So almost the only way to 
make sure you are speaking to correct physical device is to use inquire 
command and check device type and may be even serial number. The only 
consolation is that you usually do not have dozens of media changers 
connected ;)

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD7aeNR6LMutpd94wRAguxAJ97zFNUyinXEc7yQwqP7pgU+ZHQaACgsbti
eu6TLSAFR7KHVgUErhjaIZc=
=8J0V
-----END PGP SIGNATURE-----
