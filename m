Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbVIKHu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVIKHu6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 03:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVIKHu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 03:50:58 -0400
Received: from witte.sonytel.be ([80.88.33.193]:14720 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S964816AbVIKHu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 03:50:57 -0400
Date: Sun, 11 Sep 2005 09:50:38 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: viro@ZenIV.linux.org.uk
cc: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] killing linux/irq.h
In-Reply-To: <20050909184254.GT9623@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.62.0509110949390.30752@numbat.sonytel.be>
References: <20050909184254.GT9623@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005 viro@ZenIV.linux.org.uk wrote:
> 	We get regular portability bugs when somebody decides to include
> linux/irq.h into a driver instead of asm/irq.h.  It's almost always a
> wrong thing to do and, in fact, causes immediate breakage on e.g. arm.

Wouldn't it be more logical to make linux/irq.h the preferred include?
Usually the linux/* versions are preferred over the asm/* versions.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
