Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130228AbRBMOKs>; Tue, 13 Feb 2001 09:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131116AbRBMOKi>; Tue, 13 Feb 2001 09:10:38 -0500
Received: from nas14-35.wln.club-internet.fr ([213.44.68.35]:22022 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S130228AbRBMOKb>;
	Tue, 13 Feb 2001 09:10:31 -0500
Message-Id: <200102131409.PAA26445@microsoft.com>
Subject: Re: gzipped executables
From: Xavier Bestel <xavier.bestel@free.fr>
To: Matt Stegman <mas9483@ksu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21L.0102130758280.4752-100000@unix2.cc.ksu.edu>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution (0.8 - Preview Release)
Date: 13 Feb 2001 15:09:27 +0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13 Feb 2001 07:58:56 -0600, Matt Stegman a écrit :
> Hello,
> 
> Anything in 2.4 isn't an option right now.  I'm using, and am really happy
> with, the ext3 journalling patch.  I'm not planning on a 2.4 upgrade until
> ext3 has been ported.  Damn shame I don't have the skill to do that
> myself...
> 
> ext2 compression would be great. First off, though, I'm already using the
> ext3 patch.  Would ext2 compression be compatible, and take effect for
> ext3 (ext3 support is a separate option in the kernel from ext2)?  Also, I
> can't even get to the ext2 compression page
> http://e2compr.memalpha.cx/e2compr/.
> 
> UPX looks interesting; I'll have to check it out in depth.  Thanks, all!
> 
>       -Matt


If you're really adventurous, I've once done a patch for uClinux to
enable a compressed (gzip) executable format (not ELF, way lighter). It
should be at http://aplionet.aplio.fr/uclinux (the kernel loader is
linux/fs/binfmt_flat.c, the tools to generate the execs are in
tools/elf2flt)

Xav

