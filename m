Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269421AbUJSOkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269421AbUJSOkz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 10:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269422AbUJSOkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 10:40:55 -0400
Received: from aun.it.uu.se ([130.238.12.36]:6845 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S269421AbUJSOkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 10:40:45 -0400
Date: Tue, 19 Oct 2004 16:40:37 +0200 (MEST)
Message-Id: <200410191440.i9JEebIV009884@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: 4level-2.6.9-1 released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004 04:04:26 +0200, Andi Kleen wrote:
>I put a new version of the 4level page table patchkit at 
>
>ftp://ftp.suse.com/pub/people/ak/4level/4level-2.6.9-1.gz
>
>It extends the Linux VM to understand 4level page tables and extends
>the virtual address room of each x86-64 process to be 128TB (previously
>512GB) 
>
>The extension is quite straight forward without any significant
>redesign. The new level is called pml4.
>
>The patch needs some simple changes to all architectures.
>
>Changes compared to 4level-2.6.9rc4-2: 
>- Merged with 2.6.9 (release, not -final) 
>- Converted more architectures.
>
>Porting status:
>- i386   works with 2/3 levels.
>- x86-64 works with 4 levels.
>- ppc64  works with 3 levels
>- ia64   works with 3 levels
>- sh     converted, but was unable to compile because it's broken in mainline
>- ppc32  converted, compiles, not tested.

Tested on my ppc32 box. Survives booting and doing a kernel
recompile.

/Mikael
