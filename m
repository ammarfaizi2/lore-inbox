Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316043AbSHOAD0>; Wed, 14 Aug 2002 20:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSHOAD0>; Wed, 14 Aug 2002 20:03:26 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:30185 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316043AbSHOADZ>; Wed, 14 Aug 2002 20:03:25 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200208150007.g7F07JU05425@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.20-pre2-ac1
To: elenstev@mesatop.com (Steven Cole)
Date: Wed, 14 Aug 2002 20:07:19 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <1029346932.2045.128.camel@spc9.esa.lanl.gov> from "Steven Cole" at Aug 14, 2002 11:42:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fs/fs.o: In function `nfsd':
> fs/fs.o(.text+0x43fb1): undefined reference to `exp_readunlock'
> fs/fs.o: In function `sys_nfsservctl':
> fs/fs.o(.text+0x445e8): undefined reference to `exp_readunlock'
> fs/fs.o(.text+0x44692): undefined reference to `exp_readunlock'
> fs/fs.o(.data+0x261c): undefined reference to `exp_readunlock'
> make: *** [vmlinux] Error 1
> 
> Unsetting CONFIG_NFSD allowed me to build 2.4.20-pre2-ac1.

Interesting. The NFS merge was nontrivial so thats not a huge suprise.
What is however is that it apparently built for me
