Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317286AbSFCGD2>; Mon, 3 Jun 2002 02:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317287AbSFCGD1>; Mon, 3 Jun 2002 02:03:27 -0400
Received: from rj.SGI.COM ([192.82.208.96]:24285 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317286AbSFCGDW>;
	Mon, 3 Jun 2002 02:03:22 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Paul P Komkoff Jr <i@stingr.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] kbuild 2.5 ports for -pre9 and -pre9-ac1 
In-Reply-To: Your message of "Thu, 30 May 2002 23:55:44 +0400."
             <20020530195544.GC355@stingr.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Jun 2002 16:03:01 +1000
Message-ID: <31456.1023084181@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2002 23:55:44 +0400, 
Paul P Komkoff Jr <i@stingr.net> wrote:
>I'm here to announce updates of kbuild 2.5 patch to apply on 2.4.19-pre9 and
>2.4.19-pre9-ac1

Thanks for this, it shows that other people can do kbuild 2.5 work.

However there are no plans to replace the kernel build method in 2.4
kernels, it is too big a change for a stable kernel.  I have already
extracted several bugs fixes from kbuild 2.5 and fed them to Marcelo or
Alan Cox.

There is a limited amount that can be fixed in the 2.4 kernel build
without a large impact on users.  Anything that forces an upgrade past
make 3.77.1 (the currently required version on 2.4 kernels) is
unacceptable.

