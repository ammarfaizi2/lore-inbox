Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266098AbUAFXl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266101AbUAFXl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:41:56 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:37641 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S266098AbUAFXly convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:41:54 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: <linux-kernel@vger.kernel.org>
Subject: kernel buildsystem broken on RO medium
Date: Wed, 7 Jan 2004 00:41:41 +0100
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401070041.41598.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How to build external kernel modules using kernel buildsystem from RO medium?


make[1]: Entering directory `/home/users/misiek/rpm/BUILD/drbd-0.6.10/drbd'

    Calling toplevel makefile of kernel source tree, which I believe is in
    KDIR=/lib/modules/2.6.1/build
    NOTE: please ignore warnings regarding overriding of SUBDIRS

/usr/bin/make -C /lib/modules/2.6.1/build 
SUBDIRS=/home/users/misiek/rpm/BUILD/drbd-0.6.10/drbd  modules
make[2]: Entering directory `/usr/src/linux-2.6.1'
  HOSTCC  scripts/modpost.o
cc1: Permission denied: opening dependency file scripts/.modpost.o.d
make[3]: *** [scripts/modpost.o] Error 1
make[2]: *** [scripts] Error 2
make[2]: Leaving directory `/usr/src/linux-2.6.1'
make[1]: *** [kbuild] Error 2
make[1]: Leaving directory `/home/users/misiek/rpm/BUILD/drbd-0.6.10/drbd'


Are there any patches that fix this part of build system (if I remember 
correctly someone created such patch but I didn't find it)?

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux
