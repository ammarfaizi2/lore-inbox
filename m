Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSFTPjc>; Thu, 20 Jun 2002 11:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315171AbSFTPjc>; Thu, 20 Jun 2002 11:39:32 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:16995 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S315120AbSFTPja>; Thu, 20 Jun 2002 11:39:30 -0400
Date: Thu, 20 Jun 2002 17:40:46 +0200
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa3
Message-ID: <20020620154046.GA3408@chiara.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020620055933.GA1308@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020620055933.GA1308@dualathlon.random>
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
User-Agent: Mutt/1.5.1i (Linux 2.4.19-pre10-aa2 i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jun 20 2002, Andrea Arcangeli wrote:

[....]

Pre10-aa3 fails to compile on my systems:

[....]
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/local/gcc2/lib/gcc-lib/i586-pc-linux-gnu/2.95.3/include
-DKBUILD_BASENAME=ioctl  -c -o ioctl.o ioctl.c
gcc: Internal compiler error: program cc1 got fatal signal 11
make[3]: *** [ioctl.o] Error 1
make[3]: Leaving directory /usr/src/linux/fs/ext3'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory /usr/src/linux/fs/ext3'
make[1]: *** [_subdir_ext3] Error 2
make[1]: Leaving directory /usr/src/linux/fs'
make: *** [_dir_fs] Error 2
chiara:/usr/src/linux #

This is not a hardware problem, all other programs and kernels compile
without any problems (and also -aa2 and older -aa kernels).

gcc is "gcc version 2.95.3 20010315 (release)", and it also does not 
compile with "Thread model: single, gcc version 3.1". Both compilers 
built -aa2 flawlessly.

-- 
# Heinz Diehl, 68259 Mannheim, Germany
