Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131133AbRCGR5r>; Wed, 7 Mar 2001 12:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131134AbRCGR5i>; Wed, 7 Mar 2001 12:57:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8320 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131133AbRCGR51>; Wed, 7 Mar 2001 12:57:27 -0500
Date: Wed, 7 Mar 2001 12:56:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mike Galbraith <mikeg@wen-online.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ramdisk (and other) problems with 2.4.2
In-Reply-To: <Pine.LNX.4.33.0103071827320.2961-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.3.95.1010307125355.2243A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Mike Galbraith wrote:

> On Wed, 7 Mar 2001, Richard B. Johnson wrote:
> 
> > On Wed, 7 Mar 2001, Mike Galbraith wrote:
> >
> > > I'd sweat bullets over system integrity if _I_ got this reply ;-)
> > > Something is seriously amiss.
> >
> > Well now the denial phase sets in. This system has run fine for
> > two years. It ran until I tried to use new kernels.
> 
> ?? It's not denial Richard.  I showed you your script running here and
> working just fine.  As to your system running fine for two years, all
> I can say is that _every_ system runs fine until it doesn't any more.

No. It's __my__ denial phase.

> 
> There may be a problem elsewhere, but the ramdisk does not display
> the symptom you claimed it would.
> 
> > Question. How come you show a lost+found directory in the ramdisk??
> > mke2fs version 1.19 doesn't create one on a ram disk.
> 
> Well it certainly does create a lost+found here as you can see.  It
> sounds as though you're implying that I dummied up the script output.
> 

No. I did not imply that. I only stated a "so-called" fact.
Would you please check your /dev/ram0 and verify that it is:

	block special (1/0)


> > Script started on Wed Mar  7 12:22:20 2001
> > # mke2fs -Fq /dev/ram0 1440
> > mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
> > # mount /dev/ram0 /mnt
> > # ls -la /mnt
> > total 0
> > # umount /mnt
> > # exit
> > exit
> >
> > Script done on Wed Mar  7 12:23:21 2001
> >
> >
> > Also, check your logs. The errors reported don't go out to stderr.
> > They go to whatever you have set up for kernel errors.
> 
> I know what kernel messages are.  There are none.
> 
> 	-Mike
> 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


