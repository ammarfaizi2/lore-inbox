Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbTDGUaO (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 16:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTDGUaO (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 16:30:14 -0400
Received: from ip68-107-142-198.tc.ph.cox.net ([68.107.142.198]:28818 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP id S263636AbTDGUaN (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 16:30:13 -0400
Date: Mon, 7 Apr 2003 13:41:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Fabrice Bellard <fabrice.bellard@free.fr>, linux-kernel@vger.kernel.org,
       paulus@samba.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Qemu support for PPC
Message-ID: <20030407204144.GC17151@ip68-0-152-218.tc.ph.cox.net>
References: <20030407024858.C32422C014@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030407024858.C32422C014@lists.samba.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 12:40:38PM +1000, Rusty Russell wrote:

> Paul, is this OK?
> 
> I'd like it in 2.4.21 if possible.
[snip]
> diff -urpN --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.21-pre6/arch/ppc/config.in working-2.4.21-pre6-wagner/arch/ppc/config.in
> --- linux-2.4.21-pre6/arch/ppc/config.in	2003-03-27 12:10:49.000000000 +1100
> +++ working-2.4.21-pre6-wagner/arch/ppc/config.in	2003-04-04 17:11:48.000000000 +1000
> @@ -183,6 +183,7 @@ fi
>  define_bool CONFIG_BINFMT_ELF y
>  define_bool CONFIG_KERNEL_ELF y
>  tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
> +dep_tristate 'Kernel support for Linux/Intel ELF binaries' CONFIG_X86_EMU
>  
>  source drivers/pci/Config.in
>  

dep_tristate on what? :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
