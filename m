Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbUKCQgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbUKCQgH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 11:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbUKCQgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 11:36:06 -0500
Received: from mail4.speakeasy.net ([216.254.0.204]:49630 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S261700AbUKCQeg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 11:34:36 -0500
Date: Wed, 3 Nov 2004 08:34:33 -0800 (PST)
From: vlobanov <vlobanov@speakeasy.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL PATCH] /init/version.c
In-Reply-To: <200411031229.31412.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.58.0411030828560.4892@shell1.speakeasy.net>
References: <Pine.LNX.4.58.0411022359001.17128@shell2.speakeasy.net>
 <Pine.LNX.4.53.0411030929140.26206@yvahk01.tjqt.qr>
 <200411031229.31412.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to compile just fine. Here are the relevant snippets:

  UPD     include/asm-i386/asm_offsets.h
  CC      init/main.o
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  CC      init/do_mounts.o

...and...

  CC      fs/proc/proc_tty.o
  CC      fs/proc/proc_misc.o
  CC      fs/proc/kcore.o

Why did you believe it would not compile? (Just so I can be extra
careful about this kind of code in the future.)

-Vadim Lobanov

On Wed, 3 Nov 2004, Denis Vlasenko wrote:

> On Wednesday 03 November 2004 10:29, Jan Engelhardt wrote:
> > >Hi,
> > >
> > >After looking over the MAINTAINERS file, I have no idea who the right
> > >point of contact / maintainer is for this code. (Or, I simply missed the
> > >right entry while reading, which has been known to happen.) Please advise.
> >
> > As stated in the MAINTAINERS file at the end, everything else goes to Linus.
>
> However, I suspect it won't even compile.
>
> See:
> http://lxr.linux.no/source/init/main.c?v=2.6.8.1#L76
> http://lxr.linux.no/source/fs/proc/proc_misc.c?v=2.6.8.1#L253
> --
> vda
>
>
