Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSGLUbo>; Fri, 12 Jul 2002 16:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316849AbSGLUbn>; Fri, 12 Jul 2002 16:31:43 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:36361 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316541AbSGLUbm>; Fri, 12 Jul 2002 16:31:42 -0400
Date: Fri, 12 Jul 2002 22:34:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Dave Jones <davej@suse.de>
cc: Thunder from the hill <thunder@ngforever.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
In-Reply-To: <20020712203737.C18503@suse.de>
Message-ID: <Pine.LNX.4.44.0207122230360.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 12 Jul 2002, Dave Jones wrote:

>  > Which last few kernels? Was it a ffs or an ofs image? For ofs images you
>  > have to call fsx with "-W -R" to disable mmap operations.
>
> OFS afaik. Has this always been the case ? I'm sure I ran fsx without
> disabling mmap before on this image, and it used to pass.

ofs never supported mmap.

> Second bad news, with the -W -R options, it goes splat in an
> even more dramatic way.

Which kernel version? It looks like a bug which already has been fixed
quite some time ago.

bye, Roman

