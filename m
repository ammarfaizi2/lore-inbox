Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbUCaQMX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 11:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUCaQMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 11:12:23 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:53173 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S262052AbUCaQMP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 11:12:15 -0500
Date: Wed, 31 Mar 2004 09:12:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Latest kgdb?
Message-ID: <20040331161213.GJ13819@smtp.west.cox.net>
References: <20040319162009.GE4569@smtp.west.cox.net> <200403242011.26314.amitkale@emsyssoft.com> <20040324154355.GD7126@smtp.west.cox.net> <200403251022.39704.amitkale@emsyssoft.com> <20040325151444.GC13366@smtp.west.cox.net> <20040331152925.GA6205@elf.ucw.cz> <20040331154541.GH13819@smtp.west.cox.net> <20040331160806.GG220@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040331160806.GG220@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 06:08:06PM +0200, Pavel Machek wrote:

> Hi!
> 
> > > Where can I get latest kgdb? The version on kgdb.sf.net is still
> > > against 2.6.3, afaics. Or should I forward port it?
> > 
> > CVS is against 2.6.4.  Once 2.6.5 comes out, I'll move it forward again.
> > Locally, I've got a series of patches vs 2.6.5-rc3 + some -mm bits for
> > Andrew which I hope to post today, but might not make it until tomorrow.
> 
> Okay, CVS *is* against 2.6.4, but it says it is against 2.6.3. Okay to
> commit?
> 								Pavel
> Index: README
> ===================================================================
> RCS file: /cvsroot/kgdb/kgdb-2/README,v
> retrieving revision 1.5
> diff -u -u -r1.5 README
> --- README	2 Mar 2004 11:10:36 -0000	1.5
> +++ README	31 Mar 2004 15:52:54 -0000
> @@ -1,4 +1,4 @@
> -Base Kernel version: 2.6.3
> +Base Kernel version: 2.6.4
>  
>  Patch:
>  ------
> @@ -39,8 +39,8 @@
>  Supply command line options kgdbwait and kgdb8250 to the kernel.
>  Example:  kgdbwait kgdb8250=0,115200
>  (for ttyS0), then
> -   % stty 115200 < /dev/ttyS0
>     % gdb ./vmlinux
> +   (gdb) set remotebaud 115200
>     (gdb) target remote /dev/ttyS0
>  
>  Example for kgdb ethernet interface

Sure.

-- 
Tom Rini
http://gate.crashing.org/~trini/
