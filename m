Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbSKGM5s>; Thu, 7 Nov 2002 07:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266524AbSKGM5s>; Thu, 7 Nov 2002 07:57:48 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:51463 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266527AbSKGM5r>; Thu, 7 Nov 2002 07:57:47 -0500
Date: Thu, 7 Nov 2002 14:04:13 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Peter Samuelson <peter@cadcamlab.org>
cc: kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [kbuild] Possibility to sanely link against off-directory
 .so
In-Reply-To: <20021107123753.GN4182@cadcamlab.org>
Message-ID: <Pine.LNX.4.44.0211071352270.13258-100000@serv>
References: <20021106185230.GD5219@pasky.ji.cz> <20021106212952.GB1035@mars.ravnborg.org>
 <20021106220347.GE5219@pasky.ji.cz> <20021107100021.GL4182@cadcamlab.org>
 <Pine.LNX.4.44.0211071149200.13258-100000@serv> <20021107114747.GM4182@cadcamlab.org>
 <Pine.LNX.4.44.0211071258550.13258-100000@serv> <20021107123753.GN4182@cadcamlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 7 Nov 2002, Peter Samuelson wrote:

> > Shared libraries can be loaded dynamically, this means distribution can 
> > package the graphical front ends and the user doesn't need to install 
> > huge development packages.
> 
> I still don't get it.  Why can't the distribution vendor just link
> /usr/bin/qconf against $(LINUX)/scripts/kconfig/libkconfig.a?

New features will be added and only the parser that comes with the kernel 
will understand them. It's less likley that the library API will change.

bye, Roman

