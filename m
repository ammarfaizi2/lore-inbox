Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268432AbRG3Jd7>; Mon, 30 Jul 2001 05:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268160AbRG3Jdu>; Mon, 30 Jul 2001 05:33:50 -0400
Received: from mk-smarthost-2.mail.uk.worldonline.com ([212.74.112.72]:65287
	"EHLO mk-smarthost-2.mail.uk.worldonline.com") by vger.kernel.org
	with ESMTP id <S268438AbRG3Jdh>; Mon, 30 Jul 2001 05:33:37 -0400
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
X-Comment-To: Andrzej Krzysztofowicz
In-Reply-To: <fa.iv417uv.92su9n@ifi.uio.no> <fa.dgc3h1v.19gsvaq@ifi.uio.no>
Subject: Re: Kernel version 2.4.7 compile errors
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: daria.co.uk
Message-ID: <35a9.3b652a2c.b5ca8@trespassersw.daria.co.uk>
Date: Mon, 30 Jul 2001 09:34:36 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <fa.dgc3h1v.19gsvaq@ifi.uio.no>,
	Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl> writes:
>> 
>> Note: I'm not subscribed, please Cc: mark@bish.net
>> 
>> I'm trying to compile 2.4.7 with resiser support and I get this:
>> 
>> make[3]: Entering directory `/usr/src/linux/fs/reiserfs'
>> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
>> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
>> -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o inode.o inode.c
>> inode.c: In function `reiserfs_get_block':
>> inode.c:803: warning: implicit declaration of function
>> `journal_transactioo_should_end'
>> inode.c:812: `retvcl' undeclared (first use in this function)
AK> 
AK> Check your hardware. In my tree it is 'retval' as it should.
AK> 'a' and 'c' differ by a single bit ...
AK> 

Dodgy RAM. Had the same problem some time ago. The machine would run
memtest86 as long as you like, no problem. Compile a kernel and I'd
get these bit errors. Reboot, powercycle, look at the file -- no
problem, probably compile next time.

Replacing the RAM fixed the problem.


