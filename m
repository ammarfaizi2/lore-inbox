Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTFCTNp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 15:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTFCTNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 15:13:45 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:43666
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S262547AbTFCTNo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 15:13:44 -0400
Date: Tue, 3 Jun 2003 15:27:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc7
Message-ID: <20030603192711.GA22150@gtf.org>
References: <Pine.LNX.4.55L.0306031353580.3892@freak.distro.conectiva> <877k83xbbw.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877k83xbbw.fsf@sycorax.lbl.gov>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 11:30:59AM -0700, Alex Romosan wrote:
> Marcelo Tosatti <marcelo@conectiva.com.br> writes:
> 
> > Now I really hope its the last one, all this rc's are making me mad.
> 
> i still can't get it to compile for sparc32:
> 
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7   -nostdinc -iwithprefix include -DKBUILD_BASENAME=ksyms  -DEXPORT_SYMTAB -c ksyms.c
> /usr/src/linux/include/asm/checksum.h: In function `csum_partial_copy_nocheck':
> /usr/src/linux/include/asm/checksum.h:59: error: asm-specifier for variable `d' conflicts with asm clobber list
> /usr/src/linux/include/asm/checksum.h:59: error: asm-specifier for variable `l' conflicts with asm clobber list
> /usr/src/linux/include/asm/checksum.h: In function `csum_partial_copy_from_user':

That looks like you either need a different compiler version,
or different binutils version...

	Jeff



