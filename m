Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbUAMSbm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 13:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265147AbUAMSbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 13:31:41 -0500
Received: from witte.sonytel.be ([80.88.33.193]:55223 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265136AbUAMSbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 13:31:22 -0500
Date: Tue, 13 Jan 2004 19:31:16 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: John Cherry <cherry@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.1 (compile stats)
In-Reply-To: <1073661600.2709.0.camel@lightning>
Message-ID: <Pine.GSO.4.58.0401131929590.9060@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0401082242010.27013@evo.osdl.org>
 <1073661600.2709.0.camel@lightning>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004, John Cherry wrote:
> Linux 2.6 Compile Statistics (gcc 3.2.2)
> Warnings/Errors Summary
>
> Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
>              (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
> -----------  -----------  -------- -------- -------- -------- ---------
> 2.6.1          0w/0e       0w/0e   158w/ 0e  12w/0e   3w/0e    197w/0e
> 2.6.1-rc3      0w/0e       0w/0e   158w/ 0e  12w/0e   3w/0e    197w/0e
> 2.6.1-rc2      0w/0e       0w/0e   166w/ 0e  12w/0e   3w/0e    205w/0e
> 2.6.1-rc1      0w/0e       0w/0e   167w/ 0e  12w/0e   3w/0e    206w/0e
> 2.6.0          0w/0e       0w/0e   170w/ 0e  12w/0e   3w/0e    209w/0e
>
> Web page with links to complete details:
>    http://developer.osdl.org/cherry/compile/
> Daily compiles (ia32):
>    http://developer.osdl.org/cherry/compile/2.6/linus-tree/running.txt
> Daily compiles (ia64):
>    http://developer.osdl.org/cherry/compile/2.6/linus-tree/running64.txt
> Latest changes in Linus' bitkeeper tree:
>    http://linux.bkbits.net:8080/linux-2.5

While trying to make m68k use drivers/Kconfig, I keep on finding multi-bus
drivers that don't compile if CONFIG_PCI is disabled. Perhaps you want to check
for that too?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
