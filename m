Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288985AbSBKTT3>; Mon, 11 Feb 2002 14:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290211AbSBKTTU>; Mon, 11 Feb 2002 14:19:20 -0500
Received: from Expansa.sns.it ([192.167.206.189]:33042 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S288985AbSBKTTM>;
	Mon, 11 Feb 2002 14:19:12 -0500
Date: Mon, 11 Feb 2002 20:19:02 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Oleg Drokin <green@namesys.com>
cc: Alex Riesen <fork0@users.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
In-Reply-To: <20020211172747.A1815@namesys.com>
Message-ID: <Pine.LNX.4.44.0202112014210.4835-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had corruption also with 2.5.3.
I was trying to boot 2.5.4, but with preemption patch enabled i got an
oops immediatelle with swapper ;(.

Then I sepnt some time for clean i810_audio.c so it can compile, and
tomorrow I will perform some test with 2.5.4 without preemption.
I should add that finally I could corrupt a big binary file on the
pentoim III (the athlon in more important to me).
I corrupted flash plugin loading mozilla and closing
X11 without cosing mozilla before.

I did not noticed corruption with 2.5.3-pre1/2.

I could test also on a dual Pi 1260 Mhz with cpqarray controlelr, if
needed...

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

