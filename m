Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317649AbSGOVac>; Mon, 15 Jul 2002 17:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317651AbSGOVab>; Mon, 15 Jul 2002 17:30:31 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:27920 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S317649AbSGOVaa>; Mon, 15 Jul 2002 17:30:30 -0400
Message-Id: <200207152131.g6FLVveP031612@pincoya.inf.utfsm.cl>
To: "Christian Ludwig" <cl81@gmx.net>
cc: "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>
Subject: Re: bzip2 support against 2.4.18 
In-Reply-To: Message from "Christian Ludwig" <cl81@gmx.net> 
   of "Fri, 12 Jul 2002 10:32:47 +0200." <003f01c2297e$b3e395d0$1c6fa8c0@hyper> 
Date: Mon, 15 Jul 2002 17:31:56 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christian Ludwig" <cl81@gmx.net> said:

[...]

> Surely it is better not to have a capital letter. My idea to have that 'bz2'
> in the name was that you could also have some more kernel compression
> algorithms some day. For all of these you would need new names. To make it
> at least a little bit easier there should be that 'bz2' in the name. So
> 'bz2linux' would be a goal. But if we do this we also could change 'bzImage'
> to 'gzlinux'.

What for? The kernel is compressed and unzips itself on boot, which exact
compression mechanism is used is completely irrelevant to the booter, so it
has no place in the name.

Also, bzip2 is not used because it needs around 1MiB for buffers when
uncompressing, RAM which just isn't there when booting (it has to work in
the mythical PC 640KiB, IIRC). Or am I missing something here?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
