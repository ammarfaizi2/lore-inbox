Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285590AbRLGWEO>; Fri, 7 Dec 2001 17:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285592AbRLGWEF>; Fri, 7 Dec 2001 17:04:05 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:29194 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S285590AbRLGWDx>; Fri, 7 Dec 2001 17:03:53 -0500
Date: Fri, 7 Dec 2001 18:47:11 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: David Mosberger <davidm@hpl.hp.com>
Cc: Andrew Morton <akpm@zip.com.au>, j-nomura@ce.jp.nec.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
In-Reply-To: <15377.13976.342104.636304@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.21.0112071845380.22884-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Dec 2001, David Mosberger wrote:

> >>>>> On Fri, 7 Dec 2001 16:52:07 -0200 (BRST), Marcelo Tosatti <marcelo@conectiva.com.br> said:
> 
>   Marcelo> I'm really not willing to apply this kludge...
> 
> Do you agree that it should always be safe to call printk() from C code?

No if you can't access the console to print the message :) 

Its just that I would prefer to see the thing fixed in arch-dependant code
instead special casing core code. 

