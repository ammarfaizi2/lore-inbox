Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281091AbRKKVjA>; Sun, 11 Nov 2001 16:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281092AbRKKViu>; Sun, 11 Nov 2001 16:38:50 -0500
Received: from mail000.mail.bellsouth.net ([205.152.58.20]:47001 "EHLO
	imf00bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281091AbRKKVie>; Sun, 11 Nov 2001 16:38:34 -0500
Message-ID: <3BEEEFC9.4F245772@mandrakesoft.com>
Date: Sun, 11 Nov 2001 16:38:17 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
CC: joeja@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: loop back broken in 2.2.14
In-Reply-To: <3BEEED3E.58867BFE@mindspring.com> <3BEEEF1E.8050306@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

François Cami wrote:
> 
> Joe wrote:
> 
> > compile 2.2.14.
> >
> > Then
> >
> > # modprobe -a loop
> > /lib/modules/2.4.14/kernel/drivers/block/loop.o: unresolved symbol
> > deactivate_page
> > /lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod
> > /lib/modules/2.4.14/kernel/drivers/block/loop.o failed
> > /lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod loop failed
> >
> > do recursive grep through kernel tree:
> >
> > # rgrep -rl  deactivate_page *
> > drivers/block/loop.c
> > drivers/block/loop.o
> >
> > Is there a fix for this?
> 
> yes, see 2.4.15pre1
> warning, the iptables code in 2.4.15pre1 and pre2 seems broken.

and further it is likely that pre3 fixes iptables code :)
(it looks like the patch got reverted)

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

