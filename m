Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751864AbWCMLmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbWCMLmJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 06:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbWCMLmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 06:42:08 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:14225 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751864AbWCMLmH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 06:42:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=syKb69WD4/mdFUsHA7EwQsuXI5Z3jJbYCH4yYuVwTHVYOhjqVDnl8OhpyP/3OdfO029FHsAA3y7iuFMHIcSTX++cgqZyn6XAkvj2FImu5AuORFRgfRBQ5liEkSaNTqYq9v4JTKeNKaL3b6xdylpbS2HuDrbLQYHG0yPbbJVy3dk=
Message-ID: <436c596f0603130342u4d38445bt5e9f129349cda0c8@mail.gmail.com>
Date: Mon, 13 Mar 2006 08:42:06 -0300
From: j4K3xBl4sT3r <jakexblaster@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel config problem between 2.4.x to 2.6.x!
In-Reply-To: <200603130708.13685.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436c596f0603121015j2a091ab2sf43d0c5c396bbb72@mail.gmail.com>
	 <7c3341450603121247n7afe018m@mail.gmail.com>
	 <436c596f0603121632qe3151k793fd3ccd9a0eacb@mail.gmail.com>
	 <200603130708.13685.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/06, Nick Warne <nick@linicks.net> wrote:
> On 12/03/06, j4K3xBl4sT3r <jakexblaster@gmail.com> wrote:
> > I tried also installing the lastest Slackware (10.2, comes with 2.4.x
> > kernel) distro, got it working very well, until installed the Kernel
> > 2.6.x.
> >
> > The problem is:
> >
> > 1. On the slack system, when I install the 2.6.x, everything on the
> > system starts crashing, the Xorg doesnt starts anymore, the network
> > doesnt works anymore (DSL by PPPoE), and also the sound.
>
> Well, I don't know what is going on your end, but I use base Slack 10,
> and when I installed I was on 2.4.x.
>
> Then I upgraded to 2.6.x but used the .config supplied by Pat to build
> a base kernel, which all worked.  Then I modified from there.
>
> The only issue I had (later in 2.6.x development) was udev needed
> upgrading (search lkml for that thread).
>
> Nick
>

I've tried on the last 2 hrs like you, copying the .config from the
2.4.x kernel (slack 10.2) to the newest stable 2.6.15.4. The situation
now was:

1. before, the mouse worked fine. now, it doesnt works
2. before, the sound worked. and now, still working, just with ALSA,
no OSS support (tested with mpg321 and ogg123 on bash terminal)
3. strangely, the X worked fine after the kernel update, is DRM and
AGPGART needed by Xorg?
4. before, the PPPoE connected within the 2 first "." (seconds?). Now,
doesnt work, I always get TIMEOUT from PPPoE.
5. the PNPDUMP returns a empty file on the isapnptools (from the
compilation, this is the only file that gets fully compiled)

This situation happened on the Slackware 10.2, assuming a Kernel
Update. I've tryed to do the same on the last 10 mins, but the
compilation of the kernel took too long, around 50 min (I did a small
kernel just with IDE and got on 5min, and a smart kernel for my system
took 15~ mins).

On the LFS system, I still cant compile net-tools, gpm. =/

@Chris, I couldn't get the dmesg, cuz I put fire on my HDC1 first =P
and lsmod doesnt matter to much since most hardware I compile as
built-in, so it doesn't show. But I did a TarGz of this distro hehe,
so I'll try it again and show up to you here.

j4k3.
