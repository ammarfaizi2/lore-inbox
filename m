Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286353AbRLJSji>; Mon, 10 Dec 2001 13:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286359AbRLJSj2>; Mon, 10 Dec 2001 13:39:28 -0500
Received: from mail313.mail.bellsouth.net ([205.152.58.173]:61609 "EHLO
	imf13bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S286353AbRLJSjT>; Mon, 10 Dec 2001 13:39:19 -0500
Message-ID: <3C150150.3E282A1B@mandrakesoft.com>
Date: Mon, 10 Dec 2001 13:39:12 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.13-12mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.5.X Directory move for old Wavelan/Netwave drivers
In-Reply-To: <20011206155555.A18014@bougret.hpl.hp.com> <20011210103403.A20751@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a suggestion, if you are moving a bunch of files around, you might
e-mail Linus a small script he can cut-n-paste to move the files, and
then provide a patch for the stuff that is actually changed...  I don't
want to speak for Linus but at least for the rest of LKML it would make
the patches smaller and easier to read.  This was a pretty large patch
to the CC to lkml...

Even if the files are renamed then changed, IMHO a better submission
will include 
	mv dir1/foo.c dir2/foo.c
	mv dir1/bar.c dir2/bar.c

and then patch dir2/{foo,bar}.c....

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

