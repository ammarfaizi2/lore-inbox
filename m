Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292539AbSB0QSd>; Wed, 27 Feb 2002 11:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292634AbSB0QSN>; Wed, 27 Feb 2002 11:18:13 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:42762 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S292605AbSB0QSD>; Wed, 27 Feb 2002 11:18:03 -0500
Message-Id: <200202271617.g1RGHwWV012521@pincoya.inf.utfsm.cl>
To: Raphael_Manfredi@pobox.com (Raphael Manfredi)
cc: linux-kernel@vger.kernel.org
Subject: Re: setsockopt(SOL_SOCKET, SO_SNDBUF) broken on 2.4.18? 
In-Reply-To: Message from Raphael_Manfredi@pobox.com (Raphael Manfredi) 
   of "26 Feb 2002 07:46:42 GMT." <a5feh2$bvs$1@lyon.ram.loc> 
Date: Wed, 27 Feb 2002 13:17:58 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raphael_Manfredi@pobox.com (Raphael Manfredi) said:
> Quoting Alan Cox <alan@lxorguk.ukuu.org.uk> from ml.linux.kernel:
> :Neither. You asked for 8K the kernel allows a bit more for BSD compatibility
> :and other things. You query and it gives back the size it chose

> I understand the kernel can choose to allocate more than requested.
> Even double the size.  But it should be consistent, i.e. if when I request
> x it allocates 2x, then when I ask the size, I want to know x, not 2x.
> Otherwise, how can the application behave sanely if it want to vary the
> size?

By keeping track of the number, if needed?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
