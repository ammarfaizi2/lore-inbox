Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276477AbRLDBrO>; Mon, 3 Dec 2001 20:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284429AbRLDBqG>; Mon, 3 Dec 2001 20:46:06 -0500
Received: from mail307.mail.bellsouth.net ([205.152.58.167]:51895 "EHLO
	imf07bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S282275AbRLDANM>; Mon, 3 Dec 2001 19:13:12 -0500
Message-ID: <3C0C1510.DBDA6146@mandrakesoft.com>
Date: Mon, 03 Dec 2001 19:13:04 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: OSS driver cleanups.
In-Reply-To: <Pine.LNX.4.33.0112031105230.28692-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> I know OSS will be replaced with ALSA soon, but i've got a couple of OSS
> cleanup patches lined up (module usage count, power management patches
> for two cards) for both 2.4.x and 2.5.x, should i continue with them or is
> it not worthwhile?

IMHO they are useful for 2.5 series, perhaps backported to 2.4 later.

I'm sure people will continue using the OSS drivers even after they
become the "old" sound drivers... for a while at least.

Eventually we will have a pleasant future where we have a sane API that
is scalable for expensive sound hardware, with kernel changes mitigated
by a central userspace kind of libc-for-sound.  a.k.a. alsa and
alsa-lib.

Also FWIW, I support getting ALSA into the 2.5 kernel sooner rather than
later.  I had hoped to review alsa before it got in, but that kept
getting put off.

Getting ALSA into the kernel in early 2.5 will allow for a longer period
of public review, and a longer period to smooth out the rough spots and
finalize the kernel<->userspace interface.

I have style quibbles with ALSA but the ALSA guys much to their credit
are very responsive and tackle technical issues as soon as they are made
aware.  And having alsa-lib sit between kernel and userspace is the
correct and right idea, opening up all sorts of new possibilities for
the future of Linux audio.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

