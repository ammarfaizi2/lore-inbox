Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264671AbUEMTrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264671AbUEMTrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264496AbUEMTpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:45:47 -0400
Received: from mail-relay-3.tiscali.it ([212.123.84.93]:32212 "EHLO
	mail-relay-3.tiscali.i") by vger.kernel.org with ESMTP
	id S264646AbUEMTlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:41:15 -0400
From: Lorenzo Allegrucci <l_allegrucci@despammed.com>
Organization: -ENOENT
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.6-mm2
Date: Thu, 13 May 2004 21:41:12 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040513032736.40651f8e.akpm@osdl.org> <200405131707.36807.l_allegrucci@despammed.com> <20040513115516.1bbfa7b7.akpm@osdl.org>
In-Reply-To: <20040513115516.1bbfa7b7.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405132141.12245.l_allegrucci@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 May 2004 20:55, Andrew Morton wrote:
> Lorenzo Allegrucci <l_allegrucci@despammed.com> wrote:
> >  On Thursday 13 May 2004 12:27, Andrew Morton wrote:
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.
> >  >6.6-m m2/
> >
> >  make[2]: *** No rule to make target `fs/xfs/support/qsort.s', needed by
> >  `fs/xfs/support/qsort.o'.  Stop.
>
> That's odd.
>
> diff -puN fs/xfs/Makefile~have-xfs-use-kernel-provided-qsort-fix
> fs/xfs/Makefile ---
> 25/fs/xfs/Makefile~have-xfs-use-kernel-provided-qsort-fix	2004-05-13
> 11:54:24.869488456 -0700 +++ 25-akpm/fs/xfs/Makefile	2004-05-13
> 11:54:28.218979256 -0700
> @@ -142,7 +142,6 @@ xfs-y				+= $(addprefix linux/, \
>  xfs-y				+= $(addprefix support/, \
>  				   debug.o \
>  				   move.o \
> -				   qsort.o \
>  				   uuid.o)
>
>  xfs-$(CONFIG_XFS_TRACE)		+= support/ktrace.o
>
> _
>
>

Fixed, thanks.

-- 
Lorenzo
