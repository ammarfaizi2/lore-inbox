Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262591AbTCITdJ>; Sun, 9 Mar 2003 14:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262592AbTCITcE>; Sun, 9 Mar 2003 14:32:04 -0500
Received: from h-64-105-35-31.SNVACAID.covad.net ([64.105.35.31]:63109 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262591AbTCITa6>; Sun, 9 Mar 2003 14:30:58 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 9 Mar 2003 11:41:31 -0800
Message-Id: <200303091941.LAA02628@adam.yggdrasil.com>
To: torvalds@transmeta.com
Subject: Trivial: read-protected files in kernel tar distribution
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Could you please do the following (I don't know how to express
it in bitkeeper):

chmod a+r drivers/char/agp/i7x05-agp.c
chmod a+r drivers/char/agp/generic-3.0.c
chmod a+r drivers/input/joystick/grip_mp.c
chmod a+r include/video/neomagic.h

	These four files are shipped in your kernel tar distributions
as not globally readable.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
