Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbSKNRiL>; Thu, 14 Nov 2002 12:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265108AbSKNRgf>; Thu, 14 Nov 2002 12:36:35 -0500
Received: from dp.samba.org ([66.70.73.150]:57836 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265097AbSKNRgQ>;
	Thu, 14 Nov 2002 12:36:16 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrey Panin <pazke@orbita1.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module parameters reimplementation 0/4 
In-reply-to: Your message of "Thu, 14 Nov 2002 18:03:42 +0300."
             <20021114150325.GA313@pazke.ipt> 
Date: Fri, 15 Nov 2002 04:35:57 +1100
Message-Id: <20021114174310.91F402C2A5@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021114150325.GA313@pazke.ipt> you write:
> 
> --BwCQnh7xodEAoBMC
> Content-Type: text/plain; charset=utf-8
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On =D0=A7=D1=82=D0=B2, =D0=9D=D0=BE=D1=8F 14, 2002 at 03:23:00 +1100, Rusty=
>  Russell wrote:
> > Types "short", "ushort", "int", "ulong", "bool", "invbool" etc are
> > implemented pre-canned.  You can define your own, see linux/params.h
> > for how.

> Why not u8, u16, u32 etc ?

I could have, but in practice that doesn't seem to be how people use
them.  But that may be a legacy of MODULE_PARM().  If I guessed wrong,
more can be added trivially.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
