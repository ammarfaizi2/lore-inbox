Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129751AbQKGMqi>; Tue, 7 Nov 2000 07:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129926AbQKGMq3>; Tue, 7 Nov 2000 07:46:29 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:10763 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S129751AbQKGMqL>; Tue, 7 Nov 2000 07:46:11 -0500
Message-Id: <200011071245.eA7Cjhw20987@pincoya.inf.utfsm.cl>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage - modutils design 
In-Reply-To: Message from Keith Owens <kaos@ocs.com.au> 
   of "Tue, 07 Nov 2000 15:00:11 +1100." <9980.973569611@ocs3.ocs-net> 
Date: Tue, 07 Nov 2000 09:45:42 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> said:

[...]

> I have not decided where to save the persistent module parameters.  It
> could be under /lib/modules/<version>/persist or it could be under
> /var/log or /var/run.  I am tending towards /var/run/module_persist, in
> any case it will be a modules.conf parameter.

/var/lib/persist/<version>/<wherever-the-module-is-in-/lib/modules/<version>/>

or some such. It has to match the kernel version somewhere (in case module
interfaces change), and it also should mirror the tree under
/lib/modules/<version> if for no other reason that there might show up
several modules named <foo>.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
