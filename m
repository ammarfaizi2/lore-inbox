Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbUKFAsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbUKFAsZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 19:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbUKFAsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 19:48:24 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:18592 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261276AbUKFAsU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 19:48:20 -0500
Date: Sat, 6 Nov 2004 01:48:09 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] change Kconfig entry for RAMFS
In-Reply-To: <Pine.LNX.4.60.0411060027560.3255@alpha.polcom.net>
Message-ID: <Pine.LNX.4.60.0411060142570.3255@alpha.polcom.net>
References: <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
 <20041103233029.GA16982@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org> <20041105014146.GA7397@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org> <20041105195045.GA16766@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411051203470.2223@ppc970.osdl.org>
 <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net>
 <Pine.LNX.4.58.0411051406200.2223@ppc970.osdl.org>
 <Pine.LNX.4.60.0411052319160.3255@alpha.polcom.net>
 <Pine.LNX.4.58.0411051506590.2223@ppc970.osdl.org>
 <Pine.LNX.4.60.0411060027560.3255@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, I am stupid. As DaMouse pointed out I diffed against wrong kernel 
(-cko2 instead vanilla). Sorry. Here is updated patch:

Signed-off-by: Grzegorz Kulewski <kangur@polcom.net>

--- linux-2.6.9/fs/Kconfig	 2004-11-06 01:11:58.900541536 +0100
+++ linux-2.6.9-gk/fs/Kconfig	 2004-11-06 01:13:04.432579152 +0100
@@ -937,9 +937,6 @@
           you need a file system which lives in RAM with limit checking use
           tmpfs.

-         To compile this as a module, choose M here: the module will be called
-         ramfs.
-
  endmenu

  menu "Miscellaneous filesystems"
-

I hope it is good now. And I hope my mailer doesn't destroy the patch?


Thanks,

Grzegorz Kulewski

