Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131711AbRCVNri>; Thu, 22 Mar 2001 08:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131720AbRCVNr2>; Thu, 22 Mar 2001 08:47:28 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:30227 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S131711AbRCVNrN>; Thu, 22 Mar 2001 08:47:13 -0500
Message-Id: <200103221346.f2MDkHfR018052@pincoya.inf.utfsm.cl>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2_unlink fun 
In-Reply-To: Your message of "Wed, 21 Mar 2001 10:24:36 EST."
             <Pine.LNX.4.32.0103211016570.15278-100000@viper.haque.net> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Thu, 22 Mar 2001 09:46:17 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mohammad A. Haque" <mhaque@haque.net> said:
> My machine locked hard last night for an unknown reason under
> 2.4.3-pre4. Rebooted and it did it's fsck thing. Got alot of errors
> about missing '..', fixed alot of things and moved some stuff to
> /lost+found.
> 
> Some files got screwed up so I can't delete them.

Usually wierd permissions, in particular, spurious immutable flags. Has
happened to me when bugs in the kernel wrote garbage over inodes. Try
lsattr(1), chattr(1). Or debugfs(8) or such.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
