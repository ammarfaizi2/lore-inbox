Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267761AbTBYGdE>; Tue, 25 Feb 2003 01:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267762AbTBYGdE>; Tue, 25 Feb 2003 01:33:04 -0500
Received: from h-64-105-35-241.SNVACAID.covad.net ([64.105.35.241]:60363 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267761AbTBYGdD>; Tue, 25 Feb 2003 01:33:03 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 24 Feb 2003 22:33:39 -0800
Message-Id: <200302250633.WAA06979@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Replacement for "make SUBDIRS=...." in 2.5.63?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I see that if I do something like "make SUBDIRS=net/ipv4 modules",
I get warnings like:

*** Warning: Overriding SUBDIRS on the command line can cause inconsistencies
*** Uh-oh, you have stale module entries. You messed with SUBDIRS

	What is the proper way to rebuild just one subdirectory?  How
about for building externally provided modules?  Is this is a new
limitation of kbuild?  If so, I think it will reduce my productivity,
and probably developer productivity on average.  I need to rebuild
small sets of modules or core kernel subdirectories frequently.  I'd
like to know what benefits I get from this so that I can measure
whether this really saves me time somehow.

	I suspect that this was added to support putting module
dependencies into the ".ko" files, which might be underlying issue
that needs a cost/benefit review, but perhaps there is some other
factor that I'm just unaware of.

	Any answers to these questions would be appreciated.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
