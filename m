Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319344AbSHNVIL>; Wed, 14 Aug 2002 17:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319342AbSHNVHB>; Wed, 14 Aug 2002 17:07:01 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:20156 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S319315AbSHNVFi>; Wed, 14 Aug 2002 17:05:38 -0400
Subject: Re: Linux 2.4.20-pre2-ac1
From: Steven Cole <elenstev@mesatop.com>
To: Greg Louis <glouis@dynamicro.on.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020814162924.6a4203ef.glouis@dynamicro.on.ca>
References: <200208141634.g7EGYGO29387@devserv.devel.redhat.com>
	<1029346932.2045.128.camel@spc9.esa.lanl.gov> 
	<20020814162924.6a4203ef.glouis@dynamicro.on.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 14 Aug 2002 15:06:32 -0600
Message-Id: <1029359192.2051.155.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-14 at 14:29, Greg Louis wrote:
> On 14 Aug 2002 11:42:11 -0600,
>  Steven Cole <elenstev@mesatop.com> wrote:
> 
> > On Wed, 2002-08-14 at 10:34, Alan Cox wrote:
> > 
> > > 
> > > Linux 2.4.20-pre2-ac1
> > 
> > With CONFIG_NFSD=y I got this:
> > 
> > fs/fs.o: In function `nfsd':
> > fs/fs.o(.text+0x43fb1): undefined reference to `exp_readunlock'
> > fs/fs.o: In function `sys_nfsservctl':
> > fs/fs.o(.text+0x445e8): undefined reference to `exp_readunlock'
> > fs/fs.o(.text+0x44692): undefined reference to `exp_readunlock'
> > fs/fs.o(.data+0x261c): undefined reference to `exp_readunlock'
> > make: *** [vmlinux] Error 1
> > 
> This looks as though it ought to work (though I'm not at all familiar
> with the code), and seems to be working for me on one box where I've
> run it:
[patch snipped]

Yep, that allowed it to build with CONFIG_NFSD=y.  I just can't test
it as I've got my test box busy doing other things for a while.

Thanks,
Steven


