Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131126AbRCGRw1>; Wed, 7 Mar 2001 12:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131131AbRCGRwN>; Wed, 7 Mar 2001 12:52:13 -0500
Received: from www.wen-online.de ([212.223.88.39]:17423 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131126AbRCGRv7>;
	Wed, 7 Mar 2001 12:51:59 -0500
Date: Wed, 7 Mar 2001 18:51:35 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ramdisk (and other) problems with 2.4.2
In-Reply-To: <Pine.LNX.3.95.1010307121716.1838A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0103071827320.2961-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Richard B. Johnson wrote:

> On Wed, 7 Mar 2001, Mike Galbraith wrote:
>
> > I'd sweat bullets over system integrity if _I_ got this reply ;-)
> > Something is seriously amiss.
>
> Well now the denial phase sets in. This system has run fine for
> two years. It ran until I tried to use new kernels.

?? It's not denial Richard.  I showed you your script running here and
working just fine.  As to your system running fine for two years, all
I can say is that _every_ system runs fine until it doesn't any more.

There may be a problem elsewhere, but the ramdisk does not display
the symptom you claimed it would.

> Question. How come you show a lost+found directory in the ramdisk??
> mke2fs version 1.19 doesn't create one on a ram disk.

Well it certainly does create a lost+found here as you can see.  It
sounds as though you're implying that I dummied up the script output.

> Script started on Wed Mar  7 12:22:20 2001
> # mke2fs -Fq /dev/ram0 1440
> mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
> # mount /dev/ram0 /mnt
> # ls -la /mnt
> total 0
> # umount /mnt
> # exit
> exit
>
> Script done on Wed Mar  7 12:23:21 2001
>
>
> Also, check your logs. The errors reported don't go out to stderr.
> They go to whatever you have set up for kernel errors.

I know what kernel messages are.  There are none.

	-Mike

