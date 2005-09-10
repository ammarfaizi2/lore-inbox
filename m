Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVIJShA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVIJShA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 14:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVIJShA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 14:37:00 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:51315 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932149AbVIJShA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 14:37:00 -0400
Date: Sat, 10 Sep 2005 20:38:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Dike <jdike@addtoit.com>,
       LKML <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 2/7] i386 / uml: add dwarf sections to static link script
Message-ID: <20050910183825.GA22348@mars.ravnborg.org>
References: <20050910174452.907256000@zion.home.lan> <20050910174627.569839000@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910174627.569839000@zion.home.lan>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 07:44:54PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> Inside the linker script, insert the code for DWARF debug info sections. This
> may help GDB'ing a Uml binary. Actually, it seems that ld is able to guess
> what I added correctly, but normal linker scripts include this section so it
> should be correct anyway adding it.
> 
> On request by Sam Ravnborg <sam@ravnborg.org>, I've added it to
> asm-generic/vmlinux.lds.s. I've also moved there the stabs debug section,
> used the new macro in i386 linker script and added DWARF debug section to
> that.
Thanks!
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
