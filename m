Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290609AbSBLRNu>; Tue, 12 Feb 2002 12:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290767AbSBLRNk>; Tue, 12 Feb 2002 12:13:40 -0500
Received: from Expansa.sns.it ([192.167.206.189]:17426 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S290609AbSBLRN0>;
	Tue, 12 Feb 2002 12:13:26 -0500
Date: Tue, 12 Feb 2002 18:13:18 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Oleg Drokin <green@namesys.com>
cc: Alex Riesen <fork0@users.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
In-Reply-To: <20020212200124.A2267@namesys.com>
Message-ID: <Pine.LNX.4.44.0202121807120.15720-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I run slackware 8.0.49, and there was no log replaying.
The corruption is the one we are talking about since some days,
file are fille of 0s instead of their supposed content.

Please, note that before reboot I had no problems accessin the file, and
they resulted corrupted after reboot.



I usually restore corrupted file, so I should keep one fopr you, I think.

Luigi


On Tue, 12 Feb 2002, Oleg Drokin wrote:

> Hello!
>
>    What kind of corruption? Can we look at corrupted file if there is something
>    unusual?
>    What Linux Distribution do you run?
>
>    You can check cleanness by looking into kernel messages.
>    If there is "replaying journal" message - umount was not clean.
>
> Bye,
>     Oleg
> On Tue, Feb 12, 2002 at 05:55:54PM +0100, Luigi Genoni wrote:
> > Sorry but I got a corrupted file also with 2.5.4. I could see it after the
> > reboot to 2.4.17. It was /etc/exports and it was OK since i edited it
> > running 2.5.4, and It was readable by exportfs, so it corrupted at reboot.
> >
> > The reboot was clean, of course. Maybe wrong umount?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

