Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266502AbSKGMDP>; Thu, 7 Nov 2002 07:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266503AbSKGMDP>; Thu, 7 Nov 2002 07:03:15 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:16397 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266502AbSKGMDO>; Thu, 7 Nov 2002 07:03:14 -0500
Date: Thu, 7 Nov 2002 13:09:36 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Peter Samuelson <peter@cadcamlab.org>
cc: kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [kbuild] Possibility to sanely link against off-directory
 .so
In-Reply-To: <20021107114747.GM4182@cadcamlab.org>
Message-ID: <Pine.LNX.4.44.0211071258550.13258-100000@serv>
References: <20021106185230.GD5219@pasky.ji.cz> <20021106212952.GB1035@mars.ravnborg.org>
 <20021106220347.GE5219@pasky.ji.cz> <20021107100021.GL4182@cadcamlab.org>
 <Pine.LNX.4.44.0211071149200.13258-100000@serv> <20021107114747.GM4182@cadcamlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 7 Nov 2002, Peter Samuelson wrote:

> > If you want to limit people to the config tools in the kernel, there
> > is indeed no need for a shared library. Note that during the next
> > development cycle all graphical front ends are possibly removed.
> 
> Huh?  I don't get it.  How is a shared library any better than a static
> library in this regard?  I'm pondering the traditional advantages of
> shared libraries, and I cannot think of a single one that matters here.

Shared libraries can be loaded dynamically, this means distribution can 
package the graphical front ends and the user doesn't need to install 
huge development packages.

bye, Roman

