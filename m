Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945916AbWBCTgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945916AbWBCTgw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945918AbWBCTgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:36:52 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:61259 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1945916AbWBCTgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:36:51 -0500
Date: Fri, 03 Feb 2006 14:35:31 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [2.6.16rc2] compile error
In-reply-to: <ds08vk$hk$1@sea.gmane.org>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200602031435.31539.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <ds08vk$hk$1@sea.gmane.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 February 2006 13:55, Alexander Fieroch wrote:
>Hello,
>
>I can't compile kernel 2.6.16-rc[12] and get the following error:
>
># make
>/bin/sh: -c: line 0: syntax error near unexpected token `('
>/bin/sh: -c: line 0: `set -e; echo '  CHK    
> include/linux/version.h'; mkdir -p include/linux/;        if [ `echo
> -n "2.6.16-rc2 .file null .ident
> GCC:(GNU)4.0.320060128(prerelease)(Debian4.0.2-8) .section
> .note.GNU-stack,,@progbits" | wc -c ` -gt 64 ]; then echo
> '"2.6.16-rc2 .file null .ident
> GCC:(GNU)4.0.320060128(prerelease)(Debian4.0.2-8) .section
> .note.GNU-stack,,@progbits" exceeds 64 characters' >&2; exit 1; fi;
> (echo \#define UTS_RELEASE \"2.6.16-rc2 .file null .ident
> GCC:(GNU)4.0.320060128(prerelease)(Debian4.0.2-8) .section
>.note.GNU-stack,,@progbits\"; echo \#define LINUX_VERSION_CODE `expr 2
>\\* 65536 + 6 \\* 256 + 16`; echo '#define KERNEL_VERSION(a,b,c) (((a)
><< 16) + ((b) << 8) + (c))'; ) < /usr/src/linux-2.6.16rc2/Makefile >
>include/linux/version.h.tmp; if [ -r include/linux/version.h ] && cmp
> -s include/linux/version.h include/linux/version.h.tmp; then rm -f
> include/linux/version.h.tmp; else echo '  UPD
>include/linux/version.h'; mv -f include/linux/version.h.tmp
>include/linux/version.h; fi'
>make: *** [include/linux/version.h] Error 2
>
>
>Kernel 2.6.15 is compiling without problems. So what have I to do?
>
>Redards,
>Alexander

Did you unpack this from a .bz2 download?  Such as this is why I always 
go get the .gz versions. It just built flawlessly here, 8 warnings in 
the apm stuffs we've been looking at for years.  Fixing to reboot to it 
right now. brb.

Done, booted to it.

I scraped this from the login screen:  But it won't paste, darn.
Something about bus methods used by the w83627hf driver I think.  Is 
this supposedly being migrated to the SPI bus?  If so, howto swap 
the .config stuufs to do that?

FWIW, sensors is displaying via gkrellm just fine for the moment.

Also, its nice to see 1GB of low mem registered now.  Thanks.
 
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
