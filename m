Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262260AbTCMMnN>; Thu, 13 Mar 2003 07:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262272AbTCMMnN>; Thu, 13 Mar 2003 07:43:13 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:39075 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S262260AbTCMMnN>;
	Thu, 13 Mar 2003 07:43:13 -0500
Message-Id: <200303130103.h2D13ESc001101@eeyore.valparaiso.cl>
To: Daniel Phillips <phillips@arcor.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone 
In-Reply-To: Your message of "Wed, 12 Mar 2003 14:48:03 +0100."
             <20030312134412.4232B40CE0@mx01.nexgo.de> 
Date: Wed, 12 Mar 2003 21:03:14 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> said:

[...]

> For dependencies between changes, rather than any fixed ordering, it's better 
> to record the actual precedence information, i.e., "a before b", where a and 
> b are id numbers of changes (I think everybody agrees changes are first class 
> objects).  These precedence relations can be determined automatically: if two 
> changes do not occur in the same file, there is no certainly no precedence 
> relation.

Wrong. Edit a header adding a new type T. Later change an existing file
that already includes said header to use T. Change a function, fix most
uses. Find a wrong usage later and fix it separately. Change something, fix
its Documentation/ later. Note how you can come up with dependent changes
that _can't_ be detected automatically.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
