Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279665AbRJ0BlU>; Fri, 26 Oct 2001 21:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279667AbRJ0BlK>; Fri, 26 Oct 2001 21:41:10 -0400
Received: from mnh-1-05.mv.com ([207.22.10.37]:39437 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S279665AbRJ0BlB>;
	Fri, 26 Oct 2001 21:41:01 -0400
Message-Id: <200110270259.VAA04885@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.50-2.4.13
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Oct 2001 21:59:36 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.13 is available.

defconfig and the packaged kernels are built with CONFIG_PACKET so that 
tcpdump works.

Profiled modules can now be loaded without undefined symbols. 

Fixed a segfault on startup caused by an early unexpected malloc in a 
profiling UML. 

The network backends are now able to cleanly print the commands that 
uml_net runs and their output.

Physical memory protection is now optional and is controlled by the 'jail' 
switch until I figure out how to accomplish memory protection with x86 
segments rather than mprotect.  Clues are gratefully accepted, as I've played
with modify_ldt and have been unenlightened by the results.

UML now respects the TMP/TMPDIR/TEMPDIR environment variables.

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at 
	http://user-mode-linux.sourceforge.net/dl-sf.html

				Jeff

