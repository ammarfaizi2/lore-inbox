Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRAKXpl>; Thu, 11 Jan 2001 18:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132904AbRAKXpc>; Thu, 11 Jan 2001 18:45:32 -0500
Received: from [203.22.103.145] ([203.22.103.145]:11016 "HELO liih.org")
	by vger.kernel.org with SMTP id <S132710AbRAKXpZ>;
	Thu, 11 Jan 2001 18:45:25 -0500
Date: Fri, 12 Jan 2001 10:45:19 +1100 (EST)
From: Yin Tan Cui <cyt@liih.org>
To: <gregg_99@mailcity.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Cannot compile my kernel due to unpredictible situations: 
In-Reply-To: <HKPKHOJMBOBKGAAA@mailcity.com>
Message-ID: <Pine.LNX.4.30.0101121039590.1542-100000@flash.liih.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2001, Gregg Lloyd wrote:

>Hi,
>I have downloaded linux kernel 2.4.
>In /usr/src, I did untar the file:
>gzip -cd  linux-2.4.0.tar.gz  | tar xvf -
>I see several files being copied to several locations (/linux/Documentation,
>/linux/arch/..etc..). The problem is that there's no linux 2.4   directory created
>under /usr/src or anywhere else on my system! Anyway, there's nothing new
>under /usr/src!!!

I guess it has overwrite the files in /usr/src/linux which is the link to
your linux-2.2.5. this is why you did not see any new file/dir created.

>how can I make sure that I  am  re-compiling my kernel (currently kernel 2.2.5) with
>the right 2.4 kernel?? (Kernel howto talks about going to /usr/src/linux and
>start compiling..but current /usr/src/linux is a link to my current 2.2.5
> kernel !!!)

but the files in /usr/src/linux has probably being overwritten by files
from 2.4.0.

you should always remove the link /usr/src/linux before you untar the
kernel under /use/src or untar it in some other directory and rename it
and then move it under /usr/src.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
