Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbTBVLkS>; Sat, 22 Feb 2003 06:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267024AbTBVLkS>; Sat, 22 Feb 2003 06:40:18 -0500
Received: from angband.namesys.com ([212.16.7.85]:7045 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S266983AbTBVLkR>; Sat, 22 Feb 2003 06:40:17 -0500
Date: Sat, 22 Feb 2003 14:50:25 +0300
From: Oleg Drokin <green@namesys.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Hans Reiser <reiser@namesys.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Compile error, reiserfs, 2.4.21-pre4-ac5
Message-ID: <20030222145025.A26010@namesys.com>
References: <200302220433.44284.ivg2@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302220433.44284.ivg2@cornell.edu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Feb 22, 2003 at 04:33:27AM -0500, Ivan Gyurdiev wrote:
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-pre4-ac5/include -Wall 
> - -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> - -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon    
> - -nostdinc -iwithprefix include -DKBUILD_BASENAME=namei  -c -o namei.o namei.c
> namei.c: In function `reiserfs_mkdir':
> namei.c:651: label `out_failed' used but not defined
[...]

I am unable to reproduce.
Can you please show me your kernel config.
What gcc version do you use?
Did the patch applied cleanly for you?
(look for *.rej files in fs/reiserfs)

Thank you.

Bye,
    Oleg
