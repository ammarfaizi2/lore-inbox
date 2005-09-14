Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbVINFDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbVINFDf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 01:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbVINFDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 01:03:35 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:11950 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S965009AbVINFDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 01:03:34 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Nikita Danilov <nikita@clusterfs.com>
Subject: Re: [PATCH] use kzalloc instead of malloc+memset
Date: Wed, 14 Sep 2005 08:02:59 +0300
User-Agent: KMail/1.8.2
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       jirislaby@gmail.com, lion.vollnhals@web.de
References: <200509130010.38483.lion.vollnhals@web.de> <Pine.LNX.4.58.0509131001400.31456@sbz-30.cs.Helsinki.FI> <17190.33539.992902.463545@gargle.gargle.HOWL>
In-Reply-To: <17190.33539.992902.463545@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509140802.59435.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 September 2005 10:42, Nikita Danilov wrote:
> Pekka J Enberg writes:
> 
> [...]
> 
>  > +
>  > +The kernel provides the following general purpose memory allocators:
>  > +kmalloc(), kzalloc(), kcalloc(), and vmalloc().  Please refer to the API
>  > +documentation for further information about them.
>  > +
>  > +The preferred form for passing a size of a struct is the following:
>  > +
>  > +	p = kmalloc(sizeof(*p), ...);
> 
> Parentheses around *p are superfluous. See
> 
>  >   The C Programming Language, Second Edition
>  >   by Brian W. Kernighan and Dennis M. Ritchie.

I remember that sizeof has two forms: sizeof(type) and
sizeof(expr), and in one of them ()'s are optional.
But I fail to remember in which one. I use ()'s always.

Thanks for refreshing my memory but I'm sure
I'll forget again ;)
--
vda
