Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269092AbRHGRBY>; Tue, 7 Aug 2001 13:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269049AbRHGRBO>; Tue, 7 Aug 2001 13:01:14 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:21510 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S269041AbRHGRBB>; Tue, 7 Aug 2001 13:01:01 -0400
Message-Id: <200108071243.f77Ch6IN025609@pincoya.inf.utfsm.cl>
To: Keith Owens <kaos@ocs.com.au>
cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.7-ac8 
In-Reply-To: Message from Keith Owens <kaos@ocs.com.au> 
   of "Tue, 07 Aug 2001 15:17:49 +1000." <14551.997161469@kao2.melbourne.sgi.com> 
Date: Tue, 07 Aug 2001 08:43:06 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> said:
> @@ -27,7 +27,6 @@ AIC7XXX_OBJS += aic7xxx_pci.o
>  endif
>  
>  # Override our module desitnation
> -MOD_DESTDIR = $(shell cd .. && $(CONFIG_SHELL) $(TOPDIR)/scripts/pathdown.sh)
>  MOD_TARGET = aic7xxx.o
>  
>  include $(TOPDIR)/Rules.make

You probably should get rid of the comment before the MOD_DESTDIR too.
--
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
