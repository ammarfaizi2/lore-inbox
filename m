Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268922AbRHYMKw>; Sat, 25 Aug 2001 08:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268963AbRHYMKm>; Sat, 25 Aug 2001 08:10:42 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:28576 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S268922AbRHYMKh>;
	Sat, 25 Aug 2001 08:10:37 -0400
Date: Sat, 25 Aug 2001 14:10:33 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200108251210.OAA25028@harpo.it.uu.se>
To: ionut@cs.columbia.edu
Subject: Re: [PATCH,RFC] make ide-scsi more selective
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001 02:56:20 -0400 (EDT), Ion Badulescu wrote:

>I've concocted another patch, which includes my previous one and
>implements Mikael's idea somewhat more consistently. It adds another
>option, "noscsi", so that by saying hdX=noscsi on the kernel command line
>the user can prevent the ide-scsi driver from ever claiming that drive.
>
>So:
>- by default it's first come, first served
>- hdX=scsi means only the ide-scsi driver can claim hdX
>- hdX=noscsi means the ide-scsi driver must not claim hdX ever
>
>Sounds good? If so, please apply, it makes many CDR users' lives easier.

Looks fine to me. Tested briefly and it does get the job done.

/Mikael

p.s. anyone know if cdrecord will ever support ATAPI CDRs natively?
