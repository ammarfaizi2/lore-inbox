Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261967AbREPONH>; Wed, 16 May 2001 10:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261968AbREPOM5>; Wed, 16 May 2001 10:12:57 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:1308 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261967AbREPOMu>; Wed, 16 May 2001 10:12:50 -0400
Date: Wed, 16 May 2001 16:12:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: eccesys@topmail.de, linux-kernel@vger.kernel.org
Subject: Re: rwsem, gcc3 again
Message-ID: <20010516161203.D15796@athlon.random>
In-Reply-To: <andrea@suse.de> <10983.990021124@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10983.990021124@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Wed, May 16, 2001 at 02:52:04PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 02:52:04PM +0100, David Howells wrote:
> 
> Hi Andrea:
> 
> Here you go:
> 
> /usr/local/bin/gcc -D__KERNEL__ -I/inst-kernels/linux-2.4.5-pre2-aa/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c sys.c
> sys.c: In function `sys_gethostname':
> /inst-kernels/linux-2.4.5-pre2-aa/include/asm/rwsem_xchgadd.h:51: inconsistent
> operand constraints in an `asm'
> 
> I've lit fires underneath some of our gcc people, and they say it's definitely
> a bug in gcc. They're currently looking at it.

Ok, I hope it will be fixed soon ;), thanks for checking.

Andrea
