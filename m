Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318371AbSGYI5K>; Thu, 25 Jul 2002 04:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318374AbSGYI5K>; Thu, 25 Jul 2002 04:57:10 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:15306 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318371AbSGYI5I>;
	Thu, 25 Jul 2002 04:57:08 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: kaos@ocs.com.au, zippel@linux-m68k.org
Subject: [PATCH] New minimal module loader for testing...
Date: Thu, 25 Jul 2002 18:57:15 +1000
Message-Id: <20020725090126.6589F4112@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	Updated my in-kernel module loader patch.  Importantly, it
lacks almost all features, but it serves as a guide for the curious.
Non-x86 parts not even compiled (but tested in userspace previously,
so just some bitrot).

Name: New Module Loader Base
Author: Rusty Russell
Status: Tested on 2.5.27

D: This patch is a rewrite of the kernel module code, simplifying it
D: into an in-kernel module loader.  Note that this patch does not
D: contain any arch-specific modifications (see separate per-arch
D: patches).  Nor does it support:
D:  o Module unloading
D:  o Modversions
D:  o Module parameters.
D:  o Boot parameters.
D: To use it, you will need the trivial replacement module tools from
D: http://www.kernel.org/pub/linux/people/rusty/module-init-tools-0.2.tar.gz

http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/module-base.patch.gz
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/module-base-i386.patch.gz

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
