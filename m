Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbTH3H0O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 03:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTH3H0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 03:26:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:6032 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261693AbTH3H0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 03:26:12 -0400
Date: Sat, 30 Aug 2003 00:29:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: cijoml@volny.cz, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill CONFIG_KCORE_AOUT
Message-Id: <20030830002929.5e74ac4d.akpm@osdl.org>
In-Reply-To: <20030830072058.GI7038@fs.tum.de>
References: <200308252332.46101.cijoml@volny.cz>
	<20030826105145.GC7038@fs.tum.de>
	<20030826135323.2c33e697.akpm@osdl.org>
	<20030830070513.GH7038@fs.tum.de>
	<20030830001159.013cc6d2.akpm@osdl.org>
	<20030830072058.GI7038@fs.tum.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
>  On Sat, Aug 30, 2003 at 12:11:59AM -0700, Andrew Morton wrote:
>  > Adrian Bunk <bunk@fs.tum.de> wrote:
>  > >
>  > > The patch below kills CONFIG_KCORE_AOUT.
>  > > 
>  > >  I've tested the compilation with 2.6.0-test4.
>  > 
>  > Not on m68knommu or h8300 you haven't :)  They both
>  > select CONFIG_KCORE_AOUT in defconfig.
> 
>  The Kconfig files on these architectures had the interesting "feature" 
>  that both KCORE_AOUT and KCORE_ELF were enabled unconditionally...

heh.  Certainly it would be nice to actually delete something for once. 
It's just a matter of checking with everyone.  I'll hang onto your patch
and ask around.  Thanks.

