Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVCTVwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVCTVwK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 16:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVCTVwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 16:52:10 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:32727 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261286AbVCTVwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 16:52:07 -0500
Date: Sun, 20 Mar 2005 22:51:42 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Magnus Damm <magnus.damm@gmail.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: af_unix.c, KBUILD_MODNAME and unix
In-Reply-To: <aec7e5c30503200752b438910@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0503202250360.19507@yvahk01.tjqt.qr>
References: <aec7e5c305032005451899b18b@mail.gmail.com> 
 <20050320135207.A12839@flint.arm.linux.org.uk>  <Pine.LNX.4.61.0503201501410.31392@yvahk01.tjqt.qr>
 <aec7e5c30503200752b438910@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Why is not KBUILD_MODNAME=af_unix ?
>
>The exact solution does not matter that much to me, and I'm afraid I
>do not know how changing KBUILD_MODNAME affects the rest of the
>codebase. So basically - someone else should decide... but who?

KBUILD_MODNAME is "not used", which means you can use it for anything that 
like. You can undef it, redefine, thwap it all over and whatnot.
It's a generosity from /usr/bin/make generally providing the module with its 
own name.




Jan Engelhardt
-- 
