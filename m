Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319258AbSHNRlR>; Wed, 14 Aug 2002 13:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319259AbSHNRlR>; Wed, 14 Aug 2002 13:41:17 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:60854 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S319258AbSHNRlQ>; Wed, 14 Aug 2002 13:41:16 -0400
Subject: Re: Linux 2.4.20-pre2-ac1
From: Steven Cole <elenstev@mesatop.com>
To: Alan Cox <alan@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200208141634.g7EGYGO29387@devserv.devel.redhat.com>
References: <200208141634.g7EGYGO29387@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 14 Aug 2002 11:42:11 -0600
Message-Id: <1029346932.2045.128.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-14 at 10:34, Alan Cox wrote:

> 
> Linux 2.4.20-pre2-ac1

With CONFIG_NFSD=y I got this:

fs/fs.o: In function `nfsd':
fs/fs.o(.text+0x43fb1): undefined reference to `exp_readunlock'
fs/fs.o: In function `sys_nfsservctl':
fs/fs.o(.text+0x445e8): undefined reference to `exp_readunlock'
fs/fs.o(.text+0x44692): undefined reference to `exp_readunlock'
fs/fs.o(.data+0x261c): undefined reference to `exp_readunlock'
make: *** [vmlinux] Error 1

Unsetting CONFIG_NFSD allowed me to build 2.4.20-pre2-ac1.

Also for 2.4.20-pre2-ac1: EXTRAVERSION = -pre1-ac3

Steven

