Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVBZKoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVBZKoV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 05:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVBZKoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 05:44:21 -0500
Received: from cantor.suse.de ([195.135.220.2]:38630 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261151AbVBZKoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 05:44:19 -0500
Date: Sat, 26 Feb 2005 11:44:18 +0100
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc5: Doesn't compile with gcc-3.4 on ppc
Message-ID: <20050226104418.GA5162@suse.de>
References: <20050226103722.GB7736@aragorn.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050226103722.GB7736@aragorn.home.lxtec.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Feb 26, Elimar Riesebieter wrote:

> mm/built-in.o(.rodata.cst4+0x0): relocation truncated to fit: R_PPC_ADDR32 empty_zero_page+40000000
> make[1]: *** [.tmp_vmlinux1] Error 1
> 
> gcc (GCC) 3.4.4 20050203 (prerelease) (Debian 3.4.3-9)
> GNU ld version 2.15
> 
> Using gcc-3.3 (GCC) 3.3.5 (Debian 1:3.3.5-8) compiles well.

And so does ld 2.15 and cvs gcc 3.4.4 20050220. Bug your toolchain people.
