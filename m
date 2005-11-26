Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVKZXLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVKZXLS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 18:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVKZXLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 18:11:18 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:6244 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750777AbVKZXLS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 18:11:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WiWhUBRJ+j5KQYMw76Ya2vt0QLujriArR2aiMW1TBZ1qzOPcnAY70xbd3GV+HfA58/8jmfAxoT5kmeu0BM3aTgeMdX7Glb53nxLhtbit0UXaQpsHljISy9sQ7Rmi+Y0aJKnEQpIGlvmT4fWFMOQiKdh9dx5ByL0ynlJGeK0stmE=
Message-ID: <9c21eeae0511261511o4083b0f2we5080b550f592253@mail.gmail.com>
Date: Sat, 26 Nov 2005 15:11:17 -0800
From: David Brown <dmlb2000@gmail.com>
To: mhf@users.berlios.de
Subject: Re: linux-2.6.14.tar.bz2 permissions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051126225656.04D3D1AC3@hornet.berlios.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com>
	 <20051126223921.E7EF31AC3@hornet.berlios.de>
	 <9c21eeae0511261441j7e4cc7c7ya99daaf1e437cb2a@mail.gmail.com>
	 <20051126225656.04D3D1AC3@hornet.berlios.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry for my sleepy advise.
>
> sudo umask 022
> sudo tar jxf linux-2.6.14.1.tar.bz2 --no-same-permissions
> ls -l linux-2.6.14.1
>
> -rw-r--r--   1 root root 18693 Nov  8 20:22 COPYING
> -rw-r--r--   1 root root 89223 Nov  8 20:22 CREDITS
> drwxr-xr-x  53 root root  5208 Nov  8 20:22 Documentation
> -rw-r--r--   1 root root  1258 Nov  8 20:22 Kbuild
> -rw-r--r--   1 root root 60997 Nov  8 20:22 MAINTAINERS
> -rw-r--r--   1 root root 43534 Nov  8 20:22 Makefile
> -rw-r--r--   1 root root 14755 Nov  8 20:22 README
> -rw-r--r--   1 root root  3065 Nov  8 20:22 REPORTING-BUGS
> drwxr-xr-x  26 root root   632 Nov  8 20:22 arch
> drwxr-xr-x   2 root root   968 Nov  8 20:22 crypto
> drwxr-xr-x  22 root root   600 Nov 26 23:50 drivers
> [snip]

Aha, that option isn't in man page for tar but it is in the info page
for it... odd

Thanks, but I'd still like to know why the tarball isn't goinb to be
fixed on the main site.

- David Brown
