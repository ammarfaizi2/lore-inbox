Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVCTJvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVCTJvt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 04:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVCTJvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 04:51:49 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:29336 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262075AbVCTJvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 04:51:43 -0500
Date: Sun, 20 Mar 2005 10:51:41 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disable builtin modules
In-Reply-To: <20050319230648.19238.42743.71351@clementine.local>
Message-ID: <Pine.LNX.4.61.0503201049190.24849@yvahk01.tjqt.qr>
References: <20050319230648.19238.42743.71351@clementine.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>This patch makes it possible to disable built in code from the kernel
>command line. The patch is rather simple - it extends the compiled-in case 
>of module_init() to include __setup() with a name based on KBUILD_MODNAME.

What if there is already an option like the modname? I do not know of any 
code that currently does so, but you never know.

Are acpi= and apm= already what your patch wants to extend to other modules?
If not, there's conflict.



Jan Engelhardt
-- 
