Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTANHeh>; Tue, 14 Jan 2003 02:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261333AbTANHeh>; Tue, 14 Jan 2003 02:34:37 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:14502 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S261292AbTANHeg>; Tue, 14 Jan 2003 02:34:36 -0500
Message-Id: <200301132103.h0DL3R0p001528@eeyore.valparaiso.cl>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: exception tables in 2.5.55 
In-Reply-To: Message from Rusty Russell <rusty@rustcorp.com.au> 
   of "Mon, 13 Jan 2003 16:26:48 +1100." <20030113053002.4AE6C2C09F@lists.samba.org> 
Date: Mon, 13 Jan 2003 22:03:27 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Massive snippage of Cc:]
Rusty Russell <rusty@rustcorp.com.au>

[...]

> This seems way overkill.  How about you move the search_extable()
> prototype out of linux/module.h and into each asm/uaccess.h, then:
> 
> include/asm-m68knommu/uaccess.h:
> 
> 	/* We don't use such things. */
> 	struct exception_table_entry
> 	{
> 		int unused;
> 	};

Why not just an empty structure?
--
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
