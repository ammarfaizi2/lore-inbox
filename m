Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278226AbRJMBF1>; Fri, 12 Oct 2001 21:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278225AbRJMBFR>; Fri, 12 Oct 2001 21:05:17 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:61191 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S278224AbRJMBFC>;
	Fri, 12 Oct 2001 21:05:02 -0400
Message-Id: <200110130104.f9D14e5b021424@sleipnir.valparaiso.cl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups 
In-Reply-To: Message from Jeff Garzik <jgarzik@mandrakesoft.com> 
   of "Fri, 12 Oct 2001 15:07:14 EST." <Pine.LNX.3.96.1011012150220.6594E-100000@mandrakesoft.mandrakesoft.com> 
Date: Fri, 12 Oct 2001 21:04:38 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> said:

[...]

> We must consider the case where the kernel is built, and then a random
> 3rd party module comes along that needs crc32 features.  An ar library
> won't cut it, and neither will [the existing crc32 method of] patching
> linux/lib/crc32.c.  That leaves (a) unconditionally building it into the
> kernel, or (b) Makefile and Config.in rules.

(b) won't work if my kernel has no CRC32 modules, and a random 3rd party
module needs it. So it looks like firm builtin is the only real option (a).
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
