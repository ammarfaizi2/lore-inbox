Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132037AbRC1Raz>; Wed, 28 Mar 2001 12:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132038AbRC1Rap>; Wed, 28 Mar 2001 12:30:45 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:47887 "EHLO pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP id <S132037AbRC1Rag>; Wed, 28 Mar 2001 12:30:36 -0500
Message-Id: <200103281729.f2SHTMxY021269@pincoya.inf.utfsm.cl>
To: Shawn Starr <spstarr@sh0n.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Disturbing news.. 
In-Reply-To: Message from Shawn Starr <spstarr@sh0n.net>  of "Wed, 28 Mar 2001 02:27:47 EST." <Pine.LNX.4.30.0103280225460.8046-100000@coredump.sh0n.net> 
Date: Wed, 28 Mar 2001 13:29:22 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr <spstarr@sh0n.net> said:
> Well, why can't the ELF loader module/kernel detect or have some sort of
> restriction on modifying other/ELF binaries including itself from changing
> the Entry point?

Because there are quite valid reasons for "normal" programs (e.g., ld(1)
and other binary-futzing tools) to do so. No, I don't want a paranoic
system where I (regular user) can't do this to my own files using a random
binary editor. An executable is just a normal file in Unix, can't get
around this without seriously breaking lots of stuff.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
