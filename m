Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268923AbTBSO5F>; Wed, 19 Feb 2003 09:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268925AbTBSO5F>; Wed, 19 Feb 2003 09:57:05 -0500
Received: from ORION.sas.upenn.edu ([128.91.55.26]:37015 "EHLO
	orion.sas.upenn.edu") by vger.kernel.org with ESMTP
	id <S268923AbTBSO5E> convert rfc822-to-8bit; Wed, 19 Feb 2003 09:57:04 -0500
Date: Wed, 19 Feb 2003 10:07:04 -0500 (EST)
From: Fred K Ollinger <follinge@sas.upenn.edu>
To: axp-kernel-list@redhat.com
cc: "=?iso-8859-1?Q?'M=E5ns_Rullg=E5rd'?=" <mru@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: RE: Module problems (WAS: RE: 2.5.62 on Alpha SUCCESS (2.6 release
 soon!?))
In-Reply-To: <008001c2d7ff$aa12b420$020b10ac@pitzeier.priv.at>
Message-ID: <Pine.GSO.4.51.0302191003500.10614@mail2.sas.upenn.edu>
References: <008001c2d7ff$aa12b420$020b10ac@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Måns Rullgård wrote:
> > "Oliver Pitzeier" <o.pitzeier@uptime.at> writes:
> [ ... ]
> > > OK... Make modules_install still has problems:
> [ ... ]
> > Which versions of binutils and gcc do you have?  I get
> > similar problems with binutils 2.13 and 2.4 kernels.
>
> This is my current env.:
> [root@track /root]# rpm -q modutils binutils gcc
> modutils-2.4.22-8
> binutils-2.12.90.0.7-3
> gcc-3.1-6
>
> Maybe I should upgrade gcc? But I believe 3.1 is working fine... At least for my
> normally...

I think that gcc 3.1 should be ok.

I was wondering about modutils b/c you need newer modules-init to load
newer modules into the kernel (the extension is now .ko), but you can't
_compile_ modules, which is different. Sorry I misread the email.

Once you get modules compiled, then you need newer tools:

http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

Fred
