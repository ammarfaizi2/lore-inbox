Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbSKTKKz>; Wed, 20 Nov 2002 05:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbSKTKKz>; Wed, 20 Nov 2002 05:10:55 -0500
Received: from AGrenoble-101-1-3-164.abo.wanadoo.fr ([193.253.251.164]:63496
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S265250AbSKTKKy>; Wed, 20 Nov 2002 05:10:54 -0500
Subject: Re: spinlocks, the GPL, and binary-only modules
From: Xavier Bestel <xavier.bestel@free.fr>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Rik van Riel <riel@conectiva.com.br>,
       David McIlwraith <quack@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021120081215.GC26018@mark.mielke.cc>
References: <024101c2903f$7650a050$41368490@archaic>
	 <Pine.LNX.4.44L.0211200105090.4103-100000@imladris.surriel.com>
	 <20021120081215.GC26018@mark.mielke.cc>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1037787457.19242.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1 (Preview Release)
Date: 20 Nov 2002 11:17:37 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 20/11/2002 Ã  09:12, Mark Mielke a Ã©critÂ :
> On Wed, Nov 20, 2002 at 01:06:39AM -0200, Rik van Riel wrote:
> > On Wed, 20 Nov 2002, David McIlwraith wrote:
> > > How should it? The compiler (specifically, the C preprocessor) includes
> > > the code, thus it is not the AUTHOR violating the GPL.
> > If the compiler includes a .h file, it happens because
> > the programmer told it to do so, using a #include.
> 
> I was recently re-reading the GPL and I came to the following conclusion:
> 
> The GPL is only an issue if the software is *distributed* with GPL
> software. Meaning -- it is not legal to distribute a linux kernel that

Yeah, that's precisely the problem here: the binary-only module is
distributed with included spinlock code, which *is* GPL.

