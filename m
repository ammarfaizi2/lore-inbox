Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbUDXR3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbUDXR3g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 13:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUDXR3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 13:29:36 -0400
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:53437 "EHLO
	firestar.foogod.com") by vger.kernel.org with ESMTP id S262448AbUDXR3f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 13:29:35 -0400
Message-ID: <60004.64.139.3.221.1082827760.squirrel@www.foogod.com>
Date: Sat, 24 Apr 2004 10:29:20 -0700 (PDT)
Subject: Re: [Linux-fbdev-devel] [PATCH] neofb patches
From: "Alex Stewart" <alex@foogod.com>
To: <jsimmons@infradead.org>
In-Reply-To: <Pine.LNX.4.44.0404232241260.5826-100000@phoenix.infradead.org>
References: <56202.64.139.3.221.1082702638.squirrel@www.foogod.com>
        <Pine.LNX.4.44.0404232241260.5826-100000@phoenix.infradead.org>
X-Priority: 3
Importance: Normal
Cc: <alex@foogod.com>, <linux-fbdev-devel@lists.sourceforge.net>,
       <geert@linux-m68k.org>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Got it. I merged your patches.

Umm, I would really appreciate it if you didn't silently leave out bits of
my patches and then just say "I merged your patches".  It took me a little
bit to figure out that the reason panning now isn't used for fbconsole
scrolls is because you just didn't bother to put that part of my patch in.

Is there some reason you left out the following piece of my modedb patch?

+       /* Turn on panning for console scroll by default */
+       info->var.yres_virtual = 30000;
+       info->var.accel_flags |= FB_ACCELF_TEXT;
+       if (neofb_check_var(&info->var, info))
+               goto err_map_video;

-alex


