Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbSKTTeY>; Wed, 20 Nov 2002 14:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262371AbSKTTeY>; Wed, 20 Nov 2002 14:34:24 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:57605
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262289AbSKTTeW>; Wed, 20 Nov 2002 14:34:22 -0500
Date: Wed, 20 Nov 2002 11:40:47 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Cort Dougan <cort@fsmlabs.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Xavier Bestel <xavier.bestel@free.fr>,
       Mark Mielke <mark@mark.mielke.cc>, Rik van Riel <riel@conectiva.com.br>,
       David McIlwraith <quack@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: spinlocks, the GPL, and binary-only modules
In-Reply-To: <20021120123145.B17249@duath.fsmlabs.com>
Message-ID: <Pine.LNX.4.10.10211201137110.3892-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, Cort Dougan wrote:

> } This can be made clean if all the inlined C in the headers are pushed
> } back to an actual .c file and the make it function to call as an extern.
> } So the solution is to make a patch and publish that patch which cleans the
> } out the C code in question and move the associacted GPL license to the new
> } .c files.  This is proper and legal as structs are just the glue or api.
> } 
> } So if I publish this patch where it can be freely available for usage by
> } all, I comply with GPL.  This also removes any of the "extremists" points
> } of the smallest amount of GPL code invoked by the compiler can not touch
> } pure code.
> } 
> } Any arguments why this will not work?
> 
> Maybe something else would be better.  Adding -fno-inline to the build
> might be more useful.  It makes things a bit cleaner.
> 
> It's a nasty mess to have to do this for every subsystem when someone gets
> a wild-hair and starts inline-ing things without thinking.

Well since there is a fork for everything else,  how about a
business-linux-2.{4,5} fork?

As a place to make it even harder for the extremist to whine and cry over
the usages of binary only modules.

Comments?

Andre Hedrick
LAD Storage Consulting Group

