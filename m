Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261981AbTCPBga>; Sat, 15 Mar 2003 20:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261984AbTCPBga>; Sat, 15 Mar 2003 20:36:30 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:7575 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S261981AbTCPBg3>;
	Sat, 15 Mar 2003 20:36:29 -0500
Message-Id: <200303160039.h2G0dOLS009216@eeyore.valparaiso.cl>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone 
In-Reply-To: Your message of "Fri, 14 Mar 2003 13:29:03 +0100."
             <20030314122903.GC8057@zaurus.ucw.cz> 
Date: Sat, 15 Mar 2003 20:39:24 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> dijo:

[...]

> Some kind of better-patch is badly needed.
> 
> What kind of data would have to be in soft-changeset?
> * unique id of changeset

If you want...

> * unique id of previous changeset

What is "previous"?

> (two previous if it is merge)

And if they are merges themselves? Or if it is a 3-way merge? Etc? How do I
get the original patches (if wanted)?

> ? or would it be better to have here
> whole path to first change?
> * commit comment

Right.

> * for each file:
> ** diff -u of change
> ** file's unique id

What is that? If I moved the file away and created a new one? Other moving
around stuff?

> ** in case of rename: new name (delete is rename to special dir)
> ** in case of chmod/chown: new permissions
> ** per-file comment

Much more important: How to merge a conflicting patch in sanely? This is
perhaps the worst stumbling block on plain patches.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
