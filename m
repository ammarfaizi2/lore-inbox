Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751800AbWJVR7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbWJVR7M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 13:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWJVR7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 13:59:12 -0400
Received: from witte.sonytel.be ([80.88.33.193]:31650 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751793AbWJVR7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 13:59:11 -0400
Date: Sun, 22 Oct 2006 19:58:53 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Randy Dunlap <rdunlap@xenotime.net>
cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
In-Reply-To: <20061020091302.a2a85fb1.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.62.0610221956380.29899@pademelon.sonytel.be>
References: <20061017005025.GF29920@ftp.linux.org.uk>
 <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk>
 <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk>
 <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk>
 <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org> <20061018160609.GO29920@ftp.linux.org.uk>
 <Pine.LNX.4.64.0610180926380.3962@g5.osdl.org> <20061020005337.GV29920@ftp.linux.org.uk>
 <20061019213545.bf5a51c1.rdunlap@xenotime.net> <45389662.6010604@s5r6.in-berlin.de>
 <20061020091302.a2a85fb1.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006, Randy Dunlap wrote:
> Yes, we have lots of header include indirection going on.
> I don't know of a good tool to detect/fix it.

BTW, what about making sure all header files are self-contained (i.e. all
header files include all stuff they need)? This would make it easier for the
users to know which files to include.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
