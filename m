Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289752AbSBKOYZ>; Mon, 11 Feb 2002 09:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289757AbSBKOYG>; Mon, 11 Feb 2002 09:24:06 -0500
Received: from Expansa.sns.it ([192.167.206.189]:62734 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S289752AbSBKOYE>;
	Mon, 11 Feb 2002 09:24:04 -0500
Date: Mon, 11 Feb 2002 15:23:51 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Oleg Drokin <green@namesys.com>
cc: Alex Riesen <fork0@users.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
In-Reply-To: <20020211160948.B7863@namesys.com>
Message-ID: <Pine.LNX.4.44.0202111522130.2643-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Feb 2002, Oleg Drokin wrote:

> Hello!
>
> On Mon, Feb 11, 2002 at 01:17:13PM +0100, Alex Riesen wrote:
> > > I got the same with 2.5.4-pre1 on a  ATA66 disk,
> > > chipset i810, PentiumIII with 256 MBRAM,
> > > and then on Athlon 1300 Mhz, scsi disk, adaptec
> > > 2940UW, 512MB RAM.
> > >
> > > I saw then just after a reboot.
> > > Those file has been opened three or four days before the reboot expect of
> > > .history.
> > > I got no messages, and, that is the most interesting thing, this
> > > corruption was just for text file. I also edited some binary file with
> > > kexedit and them have not been corrupted after the reboot.
> Hm. Strange. This message have not appeared in my mailbox for some
> reason.
> .history may be corrupted if your partition was not unmounted properly
> before reboot.
other files corrupted were
/etc/rc.d/rc.local /etc/rc.d/rc.inet2
/etc/lilo.conf on the PIII

/scratch/root/<some .c source file> on the Athlon

/ partition is not the same of /home.

>
> Bye,
>     Oleg
>

