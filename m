Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSHBWrN>; Fri, 2 Aug 2002 18:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSHBWrN>; Fri, 2 Aug 2002 18:47:13 -0400
Received: from smtprelay6.dc2.adelphia.net ([64.8.50.38]:55504 "EHLO
	smtprelay6.dc2.adelphia.net") by vger.kernel.org with ESMTP
	id <S316673AbSHBWrL>; Fri, 2 Aug 2002 18:47:11 -0400
Message-ID: <000e01c23a77$03a43e90$6a01a8c0@wa1hco>
From: "jeff millar" <wa1hco@adelphia.net>
To: "Jose Luis Domingo Lopez" <linux-kernel@24x7linux.org>,
       <linux-kernel@vger.kernel.org>
References: <20020802.012040.105531210.davem@redhat.com> <008701c23a28$958ca300$6a01a8c0@wa1hco> <20020802135218.GA15211@localhost>
Subject: Re: What does this error mean? "local symbols in discarded section .text.exit"
Date: Fri, 2 Aug 2002 18:50:34 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jose...

thanks for the reply.  This link error happens with 2.5.27-2.5.30.  Are you
sure the kernel people are working on this?

jeff

----- Original Message -----
From: "Jose Luis Domingo Lopez" <linux-kernel@24x7linux.org>

> On Friday, 02 August 2002, at 09:29:09 -0400,
> jeff millar wrote:
>
> > I need some help debugging this kernel build problem.
> >
> > drivers/built-in.o(.data+0x80f4): undefined reference to `local symbols
in
> > discarded section .te
> > xt.exit'
> > make: *** [vmlinux] Error 1
> >
> A know problem with some combinations of binutils and kernel sources. As
> Debian bintuils package says:
>
> x You may experience problems linking older (and some newer) kernels with
x
> x this version of binutils.  This is not because of a bug in the linker,
x
> x but rather a bug in the kernel source.  This is being worked out and
x
> x fixed by the upstream kernel group in newer kernels, but not all of the
x
> x problems may have been fixed at this time.  Older kernel versions will
x
> x almost always exhibit the problem, however, and no attempts are being
x
> x made to fix those that we know of.
x


