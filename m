Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316818AbSE1CGU>; Mon, 27 May 2002 22:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316820AbSE1CGT>; Mon, 27 May 2002 22:06:19 -0400
Received: from zok.SGI.COM ([204.94.215.101]:23170 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316818AbSE1CGS>;
	Mon, 27 May 2002 22:06:18 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config 
In-Reply-To: Your message of "Mon, 27 May 2002 22:29:25 -0300."
             <20020528012925.GB20729@conectiva.com.br> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 May 2002 12:05:54 +1000
Message-ID: <3720.1022551554@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2002 22:29:25 -0300, 
Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:
>	Since you're working on this could I suggest that you use labeled
>elements, this gccism make the initialization above way more cleaner, safer and
>easy to read :-) This is being used in the kernel in places like the FSes, the
>TCP/IP stack and lots of other places.
>+		vendor:	     X86_VENDOR_INTEL,
>+		family:	     5,

Better still, use the C language standard:

		.vendor = X86_VENDOR_INTEL,
		.family = 5,

