Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271723AbRHUPuB>; Tue, 21 Aug 2001 11:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271727AbRHUPtx>; Tue, 21 Aug 2001 11:49:53 -0400
Received: from mailhost.lineo.fr ([194.250.46.226]:25614 "EHLO
	mailhost.lineo.fr") by vger.kernel.org with ESMTP
	id <S271723AbRHUPto>; Tue, 21 Aug 2001 11:49:44 -0400
Date: Tue, 21 Aug 2001 17:49:57 +0200
From: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Qlogic/FC firmware
Message-ID: <20010821174957.A15636@pc8.lineo.fr>
In-Reply-To: <Pine.LNX.4.33L.0108211141030.5646-100000@imladris.rielhome.conectiva> <E15ZDUM-00086s-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: =?iso-8859-1?Q?=3CE15ZDUM-00086s-00=40the-?=
	=?iso-8859-1?Q?village=2Ebc=2Enu=3E=3B_from_alan=40lxorguk=2Eukuu=2Eorg?=
	=?iso-8859-1?B?LnVrIG9uIG1hciwgYW/7?= 21, 2001 at 17:30:46 +0200
X-Mailer: Balsa 1.2.pre1-cvs20010820
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le mar, 21 aoû 2001 17:30:46, Alan Cox a écrit :
> > I guess using an initrd on these 0.3% of machines shouldn't
> > be too big a problem compared to violating the GPL and adding
> > to kernel bloat for everybody else.
> 
> The license thing is a side issue. We have a sane relationship with
> Qlogic
> so that can easily be dealt with. For 2.5 it definitely wants to be in
> initrd-tng however

I'm afraid that I don't understand what you mean by "a sane relationship
with Qlogic".
If the relation between kernel hackers and qlogic is good, why we don't
have an uptodate firmware with IP support and without license issue ?

The initial reason behind the firmware drop was the license.
And now it's a waste of RAM.

A few times ago, Dmitry (I don't remember his name but If you want I can
find it) has proposed an update for this driver including twos uptodate
firmware (with and without IP support). He give us a link to a website to
upload his patches ( http://www.datafoundation.org/qlogicfc/ ) but now the
link is broken.
If you are interresting I should be able to find his patch on an old disk.

This update resolves nearly all my problems with the in-kernel one.

And IIRC the included firmwares has no BSD license (no license at all
IIRC).

Christophe

-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com
