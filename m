Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266553AbSKGNjD>; Thu, 7 Nov 2002 08:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266554AbSKGNjD>; Thu, 7 Nov 2002 08:39:03 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:63242 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266553AbSKGNjC>; Thu, 7 Nov 2002 08:39:02 -0500
Date: Thu, 7 Nov 2002 14:45:31 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Peter Samuelson <peter@cadcamlab.org>
cc: kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [kbuild] Possibility to sanely link against off-directory
 .so
In-Reply-To: <20021107132245.GO4182@cadcamlab.org>
Message-ID: <Pine.LNX.4.44.0211071440140.6949-100000@serv>
References: <20021106185230.GD5219@pasky.ji.cz> <20021106212952.GB1035@mars.ravnborg.org>
 <20021106220347.GE5219@pasky.ji.cz> <20021107100021.GL4182@cadcamlab.org>
 <Pine.LNX.4.44.0211071149200.13258-100000@serv> <20021107114747.GM4182@cadcamlab.org>
 <Pine.LNX.4.44.0211071258550.13258-100000@serv> <20021107123753.GN4182@cadcamlab.org>
 <Pine.LNX.4.44.0211071352270.13258-100000@serv> <20021107132245.GO4182@cadcamlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 7 Nov 2002, Peter Samuelson wrote:

> Even if this is true - I'll grant you that it may be - let the vendor
> package /usr/bin/qconf as a shell script that links /usr/lib/qconf.o
> with -lqt and $(LINUX)/scripts/kconfig/libkconfig.a .  It's a little
> unorthodox, but it removes the hackery of figuring out how HOSTCC is
> supposed to build a shared library and whether any magic is needed at
> runtime.  Removes the need for the horrible stuff libtool was invented
> for, in other words.
> 
> Remember, the whole point of HOSTCC is to support a build environment
> different from the compile target - arbitrarily different, even.

If your build environment doesn't support shared libraries, you can easily 
generate a static library instead and link against it yourself, like you 
described, but it's no reason to deny the convenience to working 
environments.

bye, Roman

