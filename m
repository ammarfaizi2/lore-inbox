Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271850AbTGYAur (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 20:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271853AbTGYAur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 20:50:47 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:53408 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S271850AbTGYAuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 20:50:46 -0400
Date: Fri, 25 Jul 2003 03:05:48 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andreas Gruenbacher <agruen@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre8
In-Reply-To: <Pine.LNX.4.55L.0307241721130.7875@freak.distro.conectiva>
Message-ID: <Pine.GSO.4.21.0307250301030.28325-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jul 2003, Marcelo Tosatti wrote:
> Andreas Gruenbacher:
>   o unshare-files fix breaks file locks

Which adds one more warning (the third one below) to my build log:

| ide.c:175: warning: `ide_scan_direction' defined but not used
| ide-lib.c:174: warning: comparison of distinct pointer types lacks a cast
| binfmt_elf.c:446: warning: `files' might be used uninitialized in this function

Seems to be harmless, though.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


