Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVGaP6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVGaP6q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 11:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVGaP6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 11:58:45 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:58243 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261806AbVGaP5w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 11:57:52 -0400
Date: Sun, 31 Jul 2005 17:57:49 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: linux-kernel@vger.kernel.org
Subject: [GIT/Cogito question] Access to specific versions of the kernel
Message-Id: <Pine.OSF.4.05.10507311729460.25186-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally succeeded to get cg-clone to work on 
linux/kernel/git/torvalds/linux-2.6.git
I can see the 2.6.13-rc4 is in there and can use cg-diff to see the
difference between the current tree and 2.6.13-rc4. 

But how to I extract the 2.6.13-rc4 source from the tree?

Or even more complicated: I would like to make a branch based on
2.6.13-rc4 and work from there. At some point I would like to jump to
2.6.13-rc5 (or 2.6.13). I do not want to have the in-between changes
tickle in. I.e. I need something like "cvs rtag -b -r 2.6.13-rc4 mytress"
and "cvs update -j 2.6.13-rc4 -j 2.6.13-rc5".

In drawing

 Linus
  |
  + 2.6.13-rc3
  |
  + 2.6.13-rc4  My tree
  |             \
  | (current)    |
  |              |
  + 2.6.13-rc5   |
  |            \ |
  |              + merge point
  |              |
  + 2.6.13       |
  |            \ |
  |              + merge point

How do I do that with cogito or git?


Esben

