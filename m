Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbTCHX1B>; Sat, 8 Mar 2003 18:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262304AbTCHX1B>; Sat, 8 Mar 2003 18:27:01 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:25312 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S262303AbTCHX1A>;
	Sat, 8 Mar 2003 18:27:00 -0500
Message-Id: <200303082337.h28NbVSt001887@eeyore.valparaiso.cl>
To: margitsw@t-online.de (Margit Schubert-While)
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre5-ac2 
In-Reply-To: Your message of "Fri, 07 Mar 2003 14:40:09 BST."
             <4.3.2.7.2.20030307143243.00b7abe0@pop.t-online.de> 
Date: Sat, 08 Mar 2003 20:37:30 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

margitsw@t-online.de (Margit Schubert-While) said:

Stupid question time:

> --- linux-2.4.20/drivers/video/radeon.h 2002-11-29 00:53:15.000000000 +0100
> +++ linux-2.4.20mw0/drivers/video/radeon.h      2003-03-07 

[...]

> @@ -861,6 +865,15 @@
>                  case PCI_DEVICE_ID_RADEON_PM:
>                          strcpy(rinfo->name, "Radeon P/M ");

Is this string modified later, or would it be enough to use a char *name
and go:
                           rinfo->name = "Radeon P/M";

(It looks like this would mean changes all over PCI, so...)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
