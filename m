Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263115AbVG3Tdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbVG3Tdp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVG3Tdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:33:44 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:124 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S263117AbVG3Tdb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:33:31 -0400
Date: Sat, 30 Jul 2005 21:35:32 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 1/3] uml: add dwarf sections to static link script
Message-ID: <20050730193532.GA19768@mars.ravnborg.org>
References: <20050730190534.6FB5B843@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730190534.6FB5B843@zion.home.lan>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 09:05:33PM +0200, blaisorblade@yahoo.it wrote:
> 
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Inside the linker script, insert the code for DWARF debug info sections. This
> may help GDB'ing a Uml binary. Actually, it seems that ld is able to guess
> what I added correctly, but normal linker scripts include this section so it
> should be correct anyway adding it.

Can we please have this added to include/asm-generic/vmlinux.lds.h so we
can share the definition.

	Sam
