Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266556AbSKGNzm>; Thu, 7 Nov 2002 08:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266557AbSKGNzl>; Thu, 7 Nov 2002 08:55:41 -0500
Received: from surf.cadcamlab.org ([156.26.20.182]:17561 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S266556AbSKGNzl>; Thu, 7 Nov 2002 08:55:41 -0500
Date: Thu, 7 Nov 2002 07:59:36 -0600
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [kbuild] Possibility to sanely link against off-directory .so
Message-ID: <20021107135936.GP4182@cadcamlab.org>
References: <20021106212952.GB1035@mars.ravnborg.org> <20021106220347.GE5219@pasky.ji.cz> <20021107100021.GL4182@cadcamlab.org> <Pine.LNX.4.44.0211071149200.13258-100000@serv> <20021107114747.GM4182@cadcamlab.org> <Pine.LNX.4.44.0211071258550.13258-100000@serv> <20021107123753.GN4182@cadcamlab.org> <Pine.LNX.4.44.0211071352270.13258-100000@serv> <20021107132245.GO4182@cadcamlab.org> <Pine.LNX.4.44.0211071440140.6949-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211071440140.6949-100000@serv>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Roman Zippel]
> If your build environment doesn't support shared libraries, you can
> easily generate a static library instead and link against it
> yourself, like you described, but it's no reason to deny the
> convenience to working environments.

Yeah, but until I do, I can't even run 'make oldconfig'.

(This isn't about me - I will probably always build on Linux, with gcc
- it's about weird environments like cross-compiling from Solaris,
which I'm told was often done in the earlier stages of SPARC Linux.)

I suggest that *at least* the built-in targets should link libkconfig
statically - either via libkconfig.a or just the list of .o files.

Peter
