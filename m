Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbUDMJI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 05:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUDMJI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 05:08:59 -0400
Received: from witte.sonytel.be ([80.88.33.193]:37860 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263364AbUDMJI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 05:08:56 -0400
Date: Tue, 13 Apr 2004 11:08:53 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: JFS warnings (was: Re: Linux 2.4.26-rc3)
In-Reply-To: <20040412193313.GA5504@logos.cnet>
Message-ID: <Pine.GSO.4.58.0404131107400.19272@waterleaf.sonytel.be>
References: <20040412193313.GA5504@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2004, Marcelo Tosatti wrote:
> It includes few important USB fixes, JFS fixes, amongst others.

I'm still getting a few warnings in JFS:

| jfs_mount.c:316: warning: `AIM_byte_addr' might be used uninitialized in this function
| jfs_mount.c:316: warning: `AIT_byte_addr' might be used uninitialized in this function
| jfs_mount.c:316: warning: `fsckwsp_addr' might be used uninitialized in this function

I don't understand why, though. Happens with both m68k-linux-gcc 2.95.2 and
3.2.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
