Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289663AbSBLQ4Z>; Tue, 12 Feb 2002 11:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289813AbSBLQ4Q>; Tue, 12 Feb 2002 11:56:16 -0500
Received: from Expansa.sns.it ([192.167.206.189]:6162 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S289663AbSBLQ4G>;
	Tue, 12 Feb 2002 11:56:06 -0500
Date: Tue, 12 Feb 2002 17:55:54 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Oleg Drokin <green@namesys.com>
cc: Alex Riesen <fork0@users.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
In-Reply-To: <20020211172747.A1815@namesys.com>
Message-ID: <Pine.LNX.4.44.0202121753360.15594-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry but I got a corrupted file also with 2.5.4. I could see it after the
reboot to 2.4.17. It was /etc/exports and it was OK since i edited it
running 2.5.4, and It was readable by exportfs, so it corrupted at reboot.

The reboot was clean, of course. Maybe wrong umount?

Luigi


On Mon, 11 Feb 2002, Oleg Drokin wrote:

> Hello!
>
> On Mon, Feb 11, 2002 at 03:23:51PM +0100, Luigi Genoni wrote:
>
> > > .history may be corrupted if your partition was not unmounted properly
> > > before reboot.
> > other files corrupted were
> > /etc/rc.d/rc.local /etc/rc.d/rc.inet2
> > /etc/lilo.conf on the PIII
> > /scratch/root/<some .c source file> on the Athlon
> > / partition is not the same of /home.
> All of this on 2.5.4-pre1 only?
> Or were you able to reproduce it on later kernels too?
>
> Bye,
>     Oleg
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

