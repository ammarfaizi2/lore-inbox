Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRJ2QhM>; Mon, 29 Oct 2001 11:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276361AbRJ2QhE>; Mon, 29 Oct 2001 11:37:04 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:11280 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S276305AbRJ2QgL>; Mon, 29 Oct 2001 11:36:11 -0500
Message-Id: <200110291635.f9TGZvbD010750@pincoya.inf.utfsm.cl>
To: Stefan Hoffmeister <lkml.2001@econos.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: sysenter support 
In-Reply-To: Message from Stefan Hoffmeister <lkml.2001@econos.de> 
   of "Mon, 29 Oct 2001 10:37:08 BST." <di8qtt8fc0e2qd7qgbc57f5ut7h33ofbnv@4ax.com> 
Date: Mon, 29 Oct 2001 13:35:57 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Hoffmeister <lkml.2001@econos.de> said:
> : On Sun, 28 Oct 2001 22:43:40 -0300, Horst von Brand wrote:
> >AFAIKS you will need to
> >be able to run an i686 glibc on an i386 (install!) kernel 

> Why would you ever want to run a binary optimized for the i686 on a
> i386-optimized kernel?

When installing the system. When booting with rescue CD/floppy and trying
to run the native programs on the disk.

> Typically you will want to have a "base" glibc around which really
> serves the lowest common denominator (i386) and then optimized versions
> in the i686 / mmx / sse subdirectories which will run whenever it is
> possible to run

Right. Selected at runtime. Nice bloath + slowdown, that one...
-- 
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
