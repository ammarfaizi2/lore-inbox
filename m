Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSE1CYZ>; Mon, 27 May 2002 22:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSE1CYY>; Mon, 27 May 2002 22:24:24 -0400
Received: from rj.SGI.COM ([192.82.208.96]:57773 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S311025AbSE1CYX>;
	Mon, 27 May 2002 22:24:23 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config 
In-Reply-To: Your message of "Mon, 27 May 2002 23:16:47 -0300."
             <20020528021647.GE20729@conectiva.com.br> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 May 2002 12:24:14 +1000
Message-ID: <3937.1022552654@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2002 23:16:47 -0300, 
Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:
>Em Tue, May 28, 2002 at 12:05:54PM +1000, Keith Owens escreveu:
>> Better still, use the C language standard:
>> 
>> 		.vendor = X86_VENDOR_INTEL,
>
>oops, gcc accepts that, good to know that this is standard C, but for the
>kernel, I think that this doesn't matter as gcc is the only compiler that
>understands the GCC Language 8) Or am I wrong? I'd love to be... 8)

The kernel can only be compiled with gcc, but some bits of the build
are compiled and run on the host, using the host compiler.  Avoid using
gccisms where there is a standard way of doing it.

