Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbUJaMf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbUJaMf1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 07:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbUJaMf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 07:35:27 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:54930 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261594AbUJaMfW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 07:35:22 -0500
Date: Sun, 31 Oct 2004 14:35:21 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 505] M68k: Update defconfig for 2.6.9
Message-ID: <20041031133521.GA8260@mars.ravnborg.org>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <200410311003.i9VA3dtX009642@anakin.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410311003.i9VA3dtX009642@anakin.of.borg>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 11:03:39AM +0100, Geert Uytterhoeven wrote:
> M68k: Update defconfig for 2.6.9
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

In my tree I have a patch that allow you to say:
KBUILD_DEFCONFIG := amiga_defconfig
somewhere in arch/$(ARCH)/Makefile

Then you can decide which of your 'platforms' that should be the default
rather than having a sepcial defconfig.

I expect it to show up in -mm soon and later in -linus

	Sam
