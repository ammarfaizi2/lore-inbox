Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262541AbSI3RpZ>; Mon, 30 Sep 2002 13:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262679AbSI3RpZ>; Mon, 30 Sep 2002 13:45:25 -0400
Received: from mnh-1-22.mv.com ([207.22.10.54]:61444 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S262541AbSI3RpZ>;
	Mon, 30 Sep 2002 13:45:25 -0400
Message-Id: <200209301854.NAA03525@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Update UML to 2.5.39
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Sep 2002 13:54:04 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull http://jdike.stearns.org:5000/updates-2.5

This makes the 2.5.39 UML build and run.  All changes are in arch code.

				Jeff

ChangeSet@1.640, 2002-09-30 00:02:33-04:00, jdike@uml.karaya.com
  main.o needed to be added to the vmlinux dependencies so it would build.

ChangeSet@1.639, 2002-09-29 22:43:05-04:00, jdike@uml.karaya.com
  Moved the linker script from vmlinux.lds.S, which will be empty, to
  uml.ld.S.

ChangeSet@1.638, 2002-09-28 22:28:25-04:00, jdike@uml.karaya.com
  Updated to build with the 2.5.39 kbuild.

ChangeSet@1.637, 2002-09-28 22:23:28-04:00, jdike@uml.karaya.com
  Took the 2.5.39 Makefile changes.

ChangeSet@1.579.12.5, 2002-09-23 21:11:43-04:00, jdike@uml.karaya.com
  Bumped EXTRAVERSION for the 2.4 fixes and highmem support.

ChangeSet@1.579.12.4, 2002-09-23 14:18:45-04:00, jdike@uml.karaya.com
  One last fix to the ubd driver, allowing UML to boot.

ChangeSet@1.579.12.3, 2002-09-23 13:57:10-04:00, jdike@uml.karaya.com
  Trivial fix to the ubd driver.

ChangeSet@1.579.12.2, 2002-09-23 13:34:18-04:00, jdike@uml.karaya.com
  Cleaned up arch/um/Makefile and updated the ubd driver.

ChangeSet@1.579.12.1, 2002-09-23 12:52:56-04:00, jdike@uml.karaya.com
  UML updates to allow it to build and run as 2.5.38.


