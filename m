Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266523AbSKGMd7>; Thu, 7 Nov 2002 07:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266525AbSKGMd7>; Thu, 7 Nov 2002 07:33:59 -0500
Received: from surf.cadcamlab.org ([156.26.20.182]:3993 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S266523AbSKGMd6>; Thu, 7 Nov 2002 07:33:58 -0500
Date: Thu, 7 Nov 2002 06:37:53 -0600
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [kbuild] Possibility to sanely link against off-directory .so
Message-ID: <20021107123753.GN4182@cadcamlab.org>
References: <20021106185230.GD5219@pasky.ji.cz> <20021106212952.GB1035@mars.ravnborg.org> <20021106220347.GE5219@pasky.ji.cz> <20021107100021.GL4182@cadcamlab.org> <Pine.LNX.4.44.0211071149200.13258-100000@serv> <20021107114747.GM4182@cadcamlab.org> <Pine.LNX.4.44.0211071258550.13258-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211071258550.13258-100000@serv>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Peter Samuelson]
> > Huh?  I don't get it.  How is a shared library any better than a static
> > library in this regard?  I'm pondering the traditional advantages of
> > shared libraries, and I cannot think of a single one that matters here.

[Roman Zippel]
> Shared libraries can be loaded dynamically, this means distribution can 
> package the graphical front ends and the user doesn't need to install 
> huge development packages.

I still don't get it.  Why can't the distribution vendor just link
/usr/bin/qconf against $(LINUX)/scripts/kconfig/libkconfig.a?

Peter
