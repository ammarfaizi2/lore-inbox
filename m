Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269114AbTCBDkZ>; Sat, 1 Mar 2003 22:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269115AbTCBDkZ>; Sat, 1 Mar 2003 22:40:25 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:63975 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S269114AbTCBDkY>;
	Sat, 1 Mar 2003 22:40:24 -0500
Message-Id: <200303020317.h223GN9c003631@eeyore.valparaiso.cl>
To: Dan Kegel <dank@kegel.com>
cc: Matthias Schniedermeyer <ms@citd.de>, Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca
Subject: Re: [PATCH] kernel source spellchecker 
In-Reply-To: Your message of "Sat, 01 Mar 2003 10:54:22 -0800."
             <3E6101DE.5060301@kegel.com> 
Date: Sun, 02 Mar 2003 00:16:23 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel <dank@kegel.com> said:

[...]

> Smashing!  However, it should probably avoid correcting spellings
> in anything but C comments.

Right.

> Perhaps my C comment parser should be converted to perl and
> incorporated into spell-fix.pl, and used to divide the source
> file into two streams (comment and noncomment); the comment
> stream would be spell-fixed and merged back with the noncomment
> stream to create the output.

I wouldn't go that far. Better give a list of speling mistakes (file/line)
and fix them by hand. It won't need to be done more than occasionally, so
the overhead is not too bad.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
