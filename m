Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSKKO4A>; Mon, 11 Nov 2002 09:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265648AbSKKO4A>; Mon, 11 Nov 2002 09:56:00 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:53259 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S261495AbSKKO4A>; Mon, 11 Nov 2002 09:56:00 -0500
Message-Id: <200211111502.gABF2ajg031284@pincoya.inf.utfsm.cl>
To: hps@intermeta.de
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4.20-rc1] compiler fix drivers/ide/pdc202xx.c 
In-Reply-To: Message from "Henning P. Schmiedehausen" <hps@intermeta.de> 
   of "Mon, 11 Nov 2002 11:49:16 -0000." <aqo5fs$65i$1@forge.intermeta.de> 
Date: Mon, 11 Nov 2002 12:02:36 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Henning P. Schmiedehausen" <hps@intermeta.de> said:
> Daniel Mehrmann <daniel.mehrmann@gmx.de> writes:
> 
> >Hello Marcelo,
> 
> >i fix a compiler warning from pdc202xx.c.
> >The "default:" value in the switch was empty. Gcc don`t like
> >this. We don`t need this one. 
> 
> Correct solution is not to remove the "default:" but to add a "break;"

So people start wondering if somehow the content of the default case got
deleted by mistake? Better not. Plus it is needless (source) code bloat.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
