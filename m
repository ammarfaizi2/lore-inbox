Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262736AbTCMV6j>; Thu, 13 Mar 2003 16:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262774AbTCMV6j>; Thu, 13 Mar 2003 16:58:39 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:63151 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S262736AbTCMV6g>;
	Thu, 13 Mar 2003 16:58:36 -0500
Message-Id: <200303132107.h2DL7DAK005848@eeyore.valparaiso.cl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63)) 
In-Reply-To: Your message of "Wed, 12 Mar 2003 14:18:32 PST."
             <Pine.LNX.4.44.0303121417530.15738-100000@home.transmeta.com> 
Date: Thu, 13 Mar 2003 17:07:13 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> said:
> On Wed, 12 Mar 2003, Szakacsits Szabolcs wrote:

[...]

> > Decoding what's before is max 7-8 tries by a human and one can figure
> > out the real code from the context (with high probability).
> 
> The point being "with high probability".
> 
> I'm not adding uncertain instruction decoding to the kernel.

No need. Just dump some bytes before EIP raw, plus raw bytes + decoded
after EIP. Could be of some help.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
