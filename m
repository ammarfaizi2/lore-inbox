Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266669AbUIENje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUIENje (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 09:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUIENjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 09:39:33 -0400
Received: from [217.79.151.115] ([217.79.151.115]:53646 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S266669AbUIENja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 09:39:30 -0400
Date: Sun, 5 Sep 2004 15:39:23 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Tim Fairchild <tim@bcs4me.com>,
       Christoph Hellwig <hch@infradead.org>,
       Sid Boyce <sboyce@blueyonder.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NVIDIA Driver 1.0-6111 fix
In-Reply-To: <1094385894.1078.31.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0409051511500.4243@alpha.polcom.net>
References: <41390988.2010503@blueyonder.co.uk>  <200409041954.05272.tim@bcs4me.com>
  <1094327788.6575.209.camel@krustophenia.net>  <200409050702.29007.tim@bcs4me.com>
  <1094332949.6575.360.camel@krustophenia.net> <1094385894.1078.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Sep 2004, Alan Cox wrote:

> On Sad, 2004-09-04 at 22:22, Lee Revell wrote:
>> I have never understood why these people don't just run Windows.  I have
>> also never understood why people make so much noise about having to use
>> a closed source driver to play A CLOSED SOURCE GAME!  What's next, a
>> petition to open the UT2004 source?  Sheesh...
>
> Because a lot of them happen to like running things on Linux, or having
> the webserver still work while they are blasting aliens. You could ask a
> few of them. Thats a rather good idea when you don't understand why
> people do something. They also play a lot of open source games - bzflag,
> cube, flightgear (which does need a high end video card to do well),
> gl-117, neverball etc. Take a look at the happypenguin website some day.

Yes. Also Linux has often better performance and is way more smooth than 
Windows. I am running vanilla-rc-bk with -ck patches (and some others) and 
I can download or compile something and play my favourite game (at the 
same time) without any problems.

Also not everybody have enought money to buy Windows (and all legal 
applications that every normal Windows user must have).

And when I am using Linux I can forget about the treat that somebody will 
find my IP and will (automatically) compromise my system and install some 
worm (for example to send spam to LKML) in it. Games often have security 
holes too and if I run them on Linux on my user account I am sure that, in 
the worst scenarion, somebody will gain my normal user rights (or my 
normal game user rights) instead of "root" in Windows.

>> I suspect many of these users are ricers who tweak CFLAGS and compare
>> benchmark scores all day, and cannot bear to use the open source driver
>> if it will make their machine 1% slower.  I was surprised to find that
>
> There is certainly a strong Gentoo gaming contingent.

I am running Gentoo. I have very conservative CFLAGS and I am not 
benchmarking my system and comaring results with friends. I am using 
Gentoo mainly because it has very big amount of software "packaged", I can 
choose what software I am installing on my box (nobody will force me to 
install esd - not needed with ALSA and often harmful - just because 1000 
apps in my distribution are compiled with it), software is compiled from 
sources (its open*_source_* not openRPM or openDEB), and new versions 
of apps are appearing constantly not with 6 months release cycle. Also 
Gentoo has very good (but can-be-better) installer/deinstaller.

Yes, I am using nvidia binary only modules. But there was some time when 
nvidia binary module was not supporting 4k stacks in kernel. And I was 
using some -bk kernel that had this option and I turned it on. So I tried 
the nv X driver and later framebuffer driver. Both were absolutelly 
useless. One was freezing my box constantly and the second also had some 
mayor problems. And the quality of picture in both of them was worst than 
bad. One of them displayed some "moving background" on search 
subpages of lkml.org instead of normal background with nvidia binary 
drivers - this can yield to epilepsia or other illness in very short time. 
Of course I was unable to play my favourite tuxracer (OPENSOURCE). So I 
was forced to return to nvidia binary only driver as soon as they provided 
fixed one.

And I am using nvidia binary only driver for nearly 4 years on my GeForce 
2 and I have seen only 2 or 3 oopses caused by this driver. And I am using 
very experimental (-mm or -vanilla-bk) kernels with strange patches from 
time to time. Nearly all ooopses were reproductible with untainted kernel.


Grzegorz Kulewski

