Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310360AbSCLDJy>; Mon, 11 Mar 2002 22:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310371AbSCLDJo>; Mon, 11 Mar 2002 22:09:44 -0500
Received: from rj.sgi.com ([204.94.215.100]:32969 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S310360AbSCLDJa>;
	Mon, 11 Mar 2002 22:09:30 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: DaZZa <dazza@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems compiling kernel greater than 2.4.7 
In-Reply-To: Your message of "Tue, 12 Mar 2002 13:35:15 +1100."
             <Pine.LNX.4.30.0203121326420.12771-100000@zipperii.zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 12 Mar 2002 14:09:18 +1100
Message-ID: <6807.1015902558@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2002 13:35:15 +1100 (EST), 
DaZZa <dazza@zip.com.au> wrote:
>I'm attempting to compile a new kernel. 2.4.14 by preference, but this
>problem also exists with every version I've tried beyond 2.4.7.
>
>On installing a clean copy of the kernel source tree for ANY version after
>2.4.7, I perform the following
>
>cd /usr/src
>ln -s linux-2.4.14 linux
>cd linux
>make mrproper
>make menuconfig
>
>At this point, menuconfig runs, and I receive the initial, "Linux 2.4.14
>Kernel Configuration" blue yellow and white screen.
>
>However, selecting *ANY* menu option at this point gives the following
>error message
>
>===cut===
>There seems to be a problem with the lxdialog companion utility which is
>built prior to running Menuconfig.  Usually this is an indicator that you
>have upgraded/downgraded your ncurses libraries and did not remove the
>old ncurses header file(s) in /usr/include or /usr/include/ncurses.

An alternative cause is an incorrectly coded menu option.  Try make
xconfig, the xconfig code is much more rigorous about checking for
incorrect CML1 syntax.

