Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbTCOTfa>; Sat, 15 Mar 2003 14:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261491AbTCOTfa>; Sat, 15 Mar 2003 14:35:30 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:54483 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S261490AbTCOTf3>;
	Sat, 15 Mar 2003 14:35:29 -0500
Message-Id: <200303151840.h2FIe7Ff005637@eeyore.valparaiso.cl>
To: Jens Axboe <axboe@suse.de>
cc: Oleg Drokin <green@namesys.com>, Oleg Drokin <green@linuxhacker.ru>,
       alan@redhat.com, linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [2.4] init/do_mounts.c::rd_load_image() memleak 
In-Reply-To: Your message of "Fri, 14 Mar 2003 09:09:11 +0100."
             <20030314080911.GY836@suse.de> 
Date: Sat, 15 Mar 2003 14:40:07 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> said:
> On Fri, Mar 14 2003, Oleg Drokin wrote:

[...]

> > Do you propose somebody should go and fix all
> > if ( something )
> > 	kfree(something);
> > pieces of code to read just
> > kfree(something); ?

> No that would just be another pointless exercise in causing more
> annoyance for someone who has to look through patches finding that one
> hunk that breaks stuff. The recent spelling changes come to mind.

By that standard, most janitorial patches should be ditched. That way, no
cruft will ever be removed.

Instead of this extremist position, some way should be found that minimizes
this kind of friction.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
