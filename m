Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSLUChc>; Fri, 20 Dec 2002 21:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSLUChc>; Fri, 20 Dec 2002 21:37:32 -0500
Received: from mnh-1-22.mv.com ([207.22.10.54]:48645 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S261527AbSLUChb>;
	Fri, 20 Dec 2002 21:37:31 -0500
Message-Id: <200212210249.VAA04704@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: John Reiser <jreiser@BitWagon.com>
Cc: linux-kernel@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       Julian Seward <jseward@acm.org>
Subject: Re: Valgrind meets UML 
In-Reply-To: Your message of "Fri, 20 Dec 2002 15:32:30 PST."
             <3E03A88E.50200@BitWagon.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 20 Dec 2002 21:49:27 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jreiser@BitWagon.com said:
> I suggest that useful partial progress can be made sooner by
> identifying the allocators, telling valgrind about them and their
> external semantics, and having valgrind trust them.  

This is likely what will happen anyway.  It will likely generate noise
from inside the allocators until they are described.

> In particular, do
> not valgrind allocators at first.

This isn't possible without performing surgery on valgrind.  It has no idea
what's considered an allocator and what's not.

> Waiting for the globally correct description can take a long time,
> perhaps about as long as waiting for the authors of device drivers to
> update to a new device I/O model.

Nonsense.  They aren't going to be that complicated, and they don't change
very often anyway.

				Jeff

