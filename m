Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263986AbTFCTpi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 15:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264046AbTFCTpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 15:45:38 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:26815 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S263986AbTFCTpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 15:45:35 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc7
References: <Pine.LNX.4.55L.0306031353580.3892@freak.distro.conectiva>
	<877k83xbbw.fsf@sycorax.lbl.gov> <20030603192711.GA22150@gtf.org>
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: Tue, 03 Jun 2003 12:58:40 -0700
In-Reply-To: <20030603192711.GA22150@gtf.org> (message from Jeff Garzik on
 Tue, 3 Jun 2003 15:27:11 -0400)
Message-ID: <873cirx79r.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> On Tue, Jun 03, 2003 at 11:30:59AM -0700, Alex Romosan wrote:
>> Marcelo Tosatti <marcelo@conectiva.com.br> writes:
>> 
>> > Now I really hope its the last one, all this rc's are making me mad.
>> 
>> i still can't get it to compile for sparc32:
>> 
>> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7   -nostdinc -iwithprefix include -DKBUILD_BASENAME=ksyms  -DEXPORT_SYMTAB -c ksyms.c
>> /usr/src/linux/include/asm/checksum.h: In function `csum_partial_copy_nocheck':
>> /usr/src/linux/include/asm/checksum.h:59: error: asm-specifier for variable `d' conflicts with asm clobber list
>> /usr/src/linux/include/asm/checksum.h:59: error: asm-specifier for variable `l' conflicts with asm clobber list
>> /usr/src/linux/include/asm/checksum.h: In function `csum_partial_copy_from_user':
>
> That looks like you either need a different compiler version,
> or different binutils version...

gcc (GCC) 3.3 (Debian)
GNU ld version 2.14.90.0.4 20030523 Debian GNU/Linux

the same versions work on i386 though...

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
