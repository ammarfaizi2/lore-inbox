Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286177AbRLJHgn>; Mon, 10 Dec 2001 02:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286182AbRLJHge>; Mon, 10 Dec 2001 02:36:34 -0500
Received: from zero.tech9.net ([209.61.188.187]:43014 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S286177AbRLJHgV>;
	Mon, 10 Dec 2001 02:36:21 -0500
Subject: Re: "Colo[u]rs"
From: Robert Love <rml@tech9.net>
To: Stevie O <stevie@qrpff.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1007969208.1237.32.camel@phantasy>
In-Reply-To: <5.1.0.14.2.20011210020236.01cca428@whisper.qrpff.net> 
	<1007969208.1237.32.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 10 Dec 2001 02:36:28 -0500
Message-Id: <1007969789.1235.34.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-10 at 02:26, Robert Love wrote:

> Cache color is how many indexes there are into a cache.  Caches
> typically aren't direct mapped:

Shouldn't of said direct mapped there, they actually are direct mapped. 
I meant the function from virtual memory to cache isn't one-to-one, i.e.
multiple virtual addresses map to similar cache lines.

I should of added that n-way set associativity is increasingly making
this all less needed, but its still has benefits (the downside is there
is overhead, obviously, to making sure everything maps appropriately). 

	Robert Love

