Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbQLSB05>; Mon, 18 Dec 2000 20:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130653AbQLSB0r>; Mon, 18 Dec 2000 20:26:47 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.159.219.12]:64199 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S129930AbQLSB0l>; Mon, 18 Dec 2000 20:26:41 -0500
From: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre3
Date: Tue, 19 Dec 2000 01:58:17 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Rik Faith <faith@valinux.com>,
        "Dri-devel" <Dri-devel@lists.sourceforge.net>,
        "Alan Cox" <alan@redhat.com>
MIME-Version: 1.0
Message-Id: <00121901581700.00433@SunWave1>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> List:     linux-kernel
> Subject:  Re: test13-pre3 woes
> From:     Peter Samuelson <peter@cadcamlab.org>
> Date:     2000-12-18 9:19:13
> [Download message RAW]
>
>
> [J Sloan]
> > The module now compiles and gets installed -
> > Unfortunately, attempting to load it does not go well:
> >
> > kernel/drivers/char/drm/tdfx.o: unresolved symbol remap_page_range
> > kernel/drivers/char/drm/tdfx.o: unresolved symbol __wake_up
> > kernel/drivers/char/drm/tdfx.o: unresolved symbol mtrr_add
> > kernel/drivers/char/drm/tdfx.o: unresolved symbol __generic_copy_from_user
> > kernel/drivers/char/drm/tdfx.o: unresolved symbol schedule
> > kernel/drivers/char/drm/tdfx.o: unresolved symbol kmalloc
> > kernel/drivers/char/drm/tdfx.o: unresolved symbol si_meminfo
>
> Those symbols are rather generic and rather important.  Sounds like a
> generic module problem.  Do other modules load?  Does your kernel use
> MODVERSIONS?  (This module apparently doesn't.)  Are you using a recent
> version of modutils?
>
> Puzzled.  Maybe Keith Owens knows something.
>
> Peter

I got this, too. The one liner send here on lkm seems to be not enough. Even 
Alan's ac1/2 did not do the trick. The 'new' Linux makefile changes brake 
this stuff. It works before these changes.
So Rik any comments?

Thanks,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
