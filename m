Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291576AbSBMLPT>; Wed, 13 Feb 2002 06:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291566AbSBMLPF>; Wed, 13 Feb 2002 06:15:05 -0500
Received: from Expansa.sns.it ([192.167.206.189]:9737 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S291563AbSBMLO4>;
	Wed, 13 Feb 2002 06:14:56 -0500
Date: Wed, 13 Feb 2002 12:11:14 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Oleg Drokin <green@namesys.com>
cc: Alex Riesen <fork0@users.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
In-Reply-To: <20020213085653.A5957@namesys.com>
Message-ID: <Pine.LNX.4.44.0202131206190.19885-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Feb 2002, Oleg Drokin wrote:

> Hello!
>
> On Tue, Feb 12, 2002 at 06:13:18PM +0100, Luigi Genoni wrote:
>
> > I run slackware 8.0.49, and there was no log replaying.
> Ok.
>
> > The corruption is the one we are talking about since some days,
> > file are fille of 0s instead of their supposed content.
> Hm. Was that a plain reboot?
> Did you tried to run reiserfsck --rebuild-tree between reboots before
> finding files with zeroes.
> (if you did, that may somewhat explain what you've seen)
NO, NO.
I boot with 2.5, and I make some work, I edit dsome text file
with jed and so on,
then I do a normal reboot in 2.4.17, without any fsck,
there is log reply, it is a normal reboot.
Well, some files get corrupted.
Please, notice, I even had been so lucky to check one of them immediatelly
before the reboot (with cat), it was safe, and after it was corruted.
Please note, are corrupted just files that i wrote in 2.5.3/4.
I saw I am not the only one with this kind of corruption, I remember at
less one related mail.
I have no problem to check any patch.
Luigi
>
> > I usually restore corrupted file, so I should keep one fopr you, I think.
> Ok, if it became all zeroes, then I do not need it.
>
> Bye,
>     Oleg
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

