Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSHXON3>; Sat, 24 Aug 2002 10:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316258AbSHXON3>; Sat, 24 Aug 2002 10:13:29 -0400
Received: from p50887F28.dip.t-dialin.net ([80.136.127.40]:50339 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316235AbSHXON2>; Sat, 24 Aug 2002 10:13:28 -0400
Date: Sat, 24 Aug 2002 08:12:46 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Tomas Szepe <szepe@pinerecords.com>
Subject: [RFC] make localconfig
Message-ID: <Pine.LNX.4.44.0208240759120.3234-100000@hawkeye.luckynet.adm>
X-Location: Potsdam-Babelsberg; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

No code available yet, but while doing the compras I've physically crashed 
(on my bike) into an idea:



localconfig(9)	    Generating local configuration	    localconfig(9)

NAME
	localconfig - generate a .config for the local computer

SYNOPSIS
	make localconfig
	make dep ... etc... pp...

DESCRIPTION
	Generate a .config for the local computer, so that the kernel 
	could be built right in that moment. Therefor the local computer 
	is being examined, probed and configured and all the devices that
	we find go into your .config.

	The version is probably never 100% accurate, it might be a good 
	idea to manually recheck the .config (e.g. via make menuconfig)

	This is supposed to be a first step into a new direction where 
	we no longer copy vendor kernels from the vendor CD to the system 
	in the first position, but rather configure a new kernel for each 
	system, hoping that somewhen the boxes will be fast enough to 
	handle it in no time.

AVAILABILITY
	Linux 2.7+

SEE ALSO
	make(1), kbuild(9)

	scripts/localconfig.pl

AUTHORS
	(...)
	Thunder from the hill <thunder@ngforever.de>

BUGS
	Well, how could I tell yet?!

Linux build system	    $EPOCH+$x			    localconfig(9)





Now I want your comments...

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

