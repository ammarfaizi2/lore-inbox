Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSHYJSZ>; Sun, 25 Aug 2002 05:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSHYJSZ>; Sun, 25 Aug 2002 05:18:25 -0400
Received: from pD9E236A6.dip.t-dialin.net ([217.226.54.166]:15272 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317117AbSHYJSY>; Sun, 25 Aug 2002 05:18:24 -0400
Date: Sun, 25 Aug 2002 03:22:28 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Kerenyi Gabor <wom@tateyama.hu>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tomas Szepe <szepe@pinerecords.com>
Subject: Re: [RFC] make localconfig
In-Reply-To: <200208250657.PAA11049@cttsv008.ctt.ne.jp>
Message-ID: <Pine.LNX.4.44.0208250320360.3234-100000@hawkeye.luckynet.adm>
X-Location: Potsdam-Babelsberg; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think this version is supposed to illustrate much better what I've had 
in my mind.

localconfig(9)	  Generating local configuration	localconfig(9)

NAME
	localconfig - generate a .config for the local computer

SYNOPSIS
	make localconfig
	make dep ... etc... pp...

DESCRIPTION
	Generate a .config for the  local computer, so that the kernel
	could  be  built right  in  that  moment.  Therefor the  local
	computer is being examined,  probed and configured and all the
	devices that we find go into your .config.

	This is supposed to be a first step into a new direction where
	we no  longer copy vendor packages  from the vendor  CD to the
	system in the first place, but rather compile new packages for
	each  system, hoping  that  somewhen the  boxes  will be  fast
	enough  to handle  it  in  no time.  It's  basically a  binary
	distribution -> source distribution transition.

AVAILABILITY
	Linux 2.7+

SEE ALSO
	make(1), kbuild(9)

	scripts/localconfig.pl

AUTHORS
	(...)
	Thunder from the hill <thunder@ngforever.de>

BUGS
	The version is  probably never overly accurate, it  might be a
	good  idea to  manually  recheck the  .config  (e.g. via  make
	menuconfig) in the first versions.

Linux build system		Aug 25, 2002		localconfig(9)

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

