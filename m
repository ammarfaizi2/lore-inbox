Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285043AbRLXPJT>; Mon, 24 Dec 2001 10:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285053AbRLXPJK>; Mon, 24 Dec 2001 10:09:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:49813 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S285043AbRLXPIx>;
	Mon, 24 Dec 2001 10:08:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Christian Armingeon <linux.johnny@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: pc speaker cant be accessed with no video card in computer
Date: Mon, 24 Dec 2001 17:08:33 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C2259E2.4070504@superbt.com> <20011223013059.A53@toy.ucw.cz>
In-Reply-To: <20011223013059.A53@toy.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011224150902Z285043-18284+6971@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 23. Dezember 2001 02:30 schrieb Pavel Machek:
> Hi!
>
> > I guess it is not easy to produce a series of sounds without
> > waiting each note to finish.  There is an 8 year old PC speaker
> > driver for BSD kernel that performs the BASIC PLAY lines in kernel.
> >
> > Rather than porting it to Linux I chose a simple option of copying
> > the ioctl PC speaker code into a skeleton misc character device
> > driver.  As a result I can issue ioctl "beep" calls against my
> > /dev/pcspeaker (character device with major number 10, minor number
> > 240).  E.g., replacing "/dev/console" with "/dev/pcspeaker" in
> > PCMCIA cardmgr.c will revive its sound effects.
>
> Snip... There's driver enabling you to play mp3-s on pc speaker (etc, it
> does full /dev/dsp).... Separate task but maybe you wanted to know...
Does anybody know, where this driver is? (Homepage)

Thanks in advance,

Johnny
