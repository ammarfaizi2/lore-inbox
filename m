Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310461AbSCLHEA>; Tue, 12 Mar 2002 02:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310459AbSCLHDx>; Tue, 12 Mar 2002 02:03:53 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:54795 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S310457AbSCLHDg>; Tue, 12 Mar 2002 02:03:36 -0500
Date: Tue, 12 Mar 2002 18:03:27 +1100 (EST)
From: DaZZa <dazza@zip.com.au>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problems compiling kernel greater than 2.4.7 
In-Reply-To: <6807.1015902558@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.30.0203121801510.18387-100000@zipperii.zip.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2002, Keith Owens wrote:

> >cd /usr/src
> >ln -s linux-2.4.14 linux
> >cd linux
> >make mrproper
> >make menuconfig
> >
> >At this point, menuconfig runs, and I receive the initial, "Linux 2.4.14
> >Kernel Configuration" blue yellow and white screen.
> >
> >However, selecting *ANY* menu option at this point gives the following
> >error message
> >
> >===cut===
> >There seems to be a problem with the lxdialog companion utility which is
> >built prior to running Menuconfig.  Usually this is an indicator that you
> >have upgraded/downgraded your ncurses libraries and did not remove the
> >old ncurses header file(s) in /usr/include or /usr/include/ncurses.
>
> An alternative cause is an incorrectly coded menu option.  Try make
> xconfig, the xconfig code is much more rigorous about checking for
> incorrect CML1 syntax.

I get the same error {number 139} when attempting to run make xconfig as
well.

I'm beginning to wonder if it's something SuSE specific - anyone got any
experience with this particular distribution?

DaZZa

