Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281173AbRKOX0v>; Thu, 15 Nov 2001 18:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281175AbRKOX0m>; Thu, 15 Nov 2001 18:26:42 -0500
Received: from postfix1-2.free.fr ([213.228.0.130]:30906 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S281173AbRKOX01> convert rfc822-to-8bit; Thu, 15 Nov 2001 18:26:27 -0500
Date: Thu, 15 Nov 2001 21:41:16 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
Cc: <anton@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] small sym-2 fix
In-Reply-To: <20011115.143901.121189547.davem@redhat.com>
Message-ID: <20011115213822.C2499-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Nov 2001, David S. Miller wrote:

>    From: Gérard Roudier <groudier@free.fr>
>    Date: Thu, 15 Nov 2001 20:46:34 +0100 (CET)
>
>    diff -u ../sym-2-orig/sym_glue.h ./sym_glue.h
>    --- ../sym-2-orig/sym_glue.h	Thu Nov 15 22:53:34 2001
>    +++ ./sym_glue.h	Thu Nov 15 23:18:58 2001
>    @@ -77,7 +77,6 @@
>     #include <linux/errno.h>
>     #include <linux/pci.h>
>     #include <linux/string.h>
>    -#include <linux/malloc.h>
>     #include <linux/mm.h>
>     #include <linux/ioport.h>
>     #include <linux/time.h>
>
> Hmmm, why not add linux/slab.h?  It exists in every Linux kernel tree
> your driver would ever be compiled under.

Just because the driver has its own allocator as you know and thus does
not need this header (it didn't need malloc.h too).

  Gérard.

