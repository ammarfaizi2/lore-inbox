Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271555AbRHUElD>; Tue, 21 Aug 2001 00:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271553AbRHUEkx>; Tue, 21 Aug 2001 00:40:53 -0400
Received: from rj.SGI.COM ([204.94.215.100]:30150 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S271549AbRHUEkk>;
	Tue, 21 Aug 2001 00:40:40 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: depmod -a: unresolved symbols 
In-Reply-To: Your message of "Mon, 20 Aug 2001 17:35:57 +0300."
             <632639585.20010820173557@port.imtp.ilyichevsk.odessa.ua> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Aug 2001 14:40:38 +1000
Message-ID: <29026.998368838@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2001 17:35:57 +0300, 
VDA <VDA@port.imtp.ilyichevsk.odessa.ua> wrote:
>In kernel sources I see:
>nfsd_linkage defined and EXPORT_SYMBOLed in fs/filesystems.c
>(linked in vmlinux and bzimage, I see it in System.map),
>referenced from fs/nfsd/nfsctl.c (later linked into nfsd.o)
>So, why modprobe can't see it?
>
>kernel: 2.4.5
>I did
>make dep && \
>make clean && \
>make bzImage && \
>make modules && \
>make modules_install

http://www.tux.org/lkml/#s8-8

