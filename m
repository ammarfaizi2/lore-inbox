Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268564AbTGLWRX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 18:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268567AbTGLWRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 18:17:23 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:11396 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S268564AbTGLWRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 18:17:23 -0400
Message-Id: <200307122128.h6CLSGf1006376@eeyore.valparaiso.cl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: SECURITY - data leakage due to incorrect strncpy implementation 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "11 Jul 2003 23:10:24 +0100." <1057961423.20637.68.camel@dhcp22.swansea.linux.org.uk> 
X-Mailer: MH-E 7.1; nmh 1.0.4; XEmacs 21.4
Date: Sat, 12 Jul 2003 17:28:16 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> said:

[...]

> 2.5 you have problems all over the place from wrong strlcpy conversions,
> but those are easy enough to clean up before 2.6.0

Perhaps there should be a strncpy_touser() to make it crystal clear that it
_can't_ be "optimized" into strlcpy()
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
