Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262226AbSJNXsF>; Mon, 14 Oct 2002 19:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262240AbSJNXsF>; Mon, 14 Oct 2002 19:48:05 -0400
Received: from mnh-1-14.mv.com ([207.22.10.46]:29702 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S262226AbSJNXsE>;
	Mon, 14 Oct 2002 19:48:04 -0400
Message-Id: <200210150058.TAA05520@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: uml-patch-2.5.42-1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Oct 2002 19:58:28 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML has been updated to 2.5.42 and UML 2.4.19-12.  In non-numeric terms,
this means the following:
	the usual build fixes to keep up with kbuild
	the SMP work from UML 2.4.19-12 - it seems reasonably functional
and stable, but there are some unexplained crashes still.  Also, the fixes
from UML 2.4.19-13 aren't in yet, so an SMP UML will leave children around
after exiting (the idle threads for processors 1 ... ncpus - 1).  These 
children will interfere with rebooting, and will also hold down host memory.
	various cleanups and bug fixes

The patch is available at
	http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.42-1.bz2

For the other UML mirrors and other downloads, see 
	http://user-mode-linux.sourceforge.net/dl-sf.html

Other links of interest:

	The UML project home page : http://user-mode-linux.sourceforge.net
	The UML Community site : http://usermodelinux.org

				Jeff

