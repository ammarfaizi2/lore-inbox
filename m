Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284054AbRLAKkE>; Sat, 1 Dec 2001 05:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284053AbRLAKjx>; Sat, 1 Dec 2001 05:39:53 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:2323 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S284050AbRLAKjp>; Sat, 1 Dec 2001 05:39:45 -0500
Date: Sat, 1 Dec 2001 12:39:33 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Sven.Riedel@tu-clausthal.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: HPT370 (KT7A-RAID) *corrupts* data - SAMSUNG SV8004H does it as well
Message-ID: <20011201123933.A46995@niksula.cs.hut.fi>
In-Reply-To: <20011201115803.B10839@viasys.com> <20011201113400.A629@moog.heim1.tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011201113400.A629@moog.heim1.tu-clausthal.de>; from Sven.Riedel@tu-clausthal.de on Sat, Dec 01, 2001 at 11:34:00AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 11:34:00AM +0100, you [Sven.Riedel@tu-clausthal.de] claimed:
> On Sat, Dec 01, 2001 at 11:58:03AM +0200, Ville Herva wrote:
> > - how come anyone else is not seeing this corruption (Abit KT7A, nevermind 
> >   HPT370 is fairly popular)?
> 
> A friend of mine had an IBM DLTA drive attached to his HPT370
> controller, and this combination proved to produce a whole lot of drive
> errors (I can confirm this first hand), which went away after attaching
> the drive to the main motherboard controller.
> I can't say anything about data corruption though - I just asked him and
> he said he didn't know of any, but that doesn't mean it didn't happen.

Of course the drive is longer attached to HPT370 and your friend is propably
reluctant to reattach it, but it would still be nice to know if he gets
consistent results which for example this simple test:

  cat /dev/hde | mdsum

run for several (5-10, perhaps) times.

OTOH, I haven't had corruption with reading only 
one disk at a time, but then again I haven't tried too hard as they 
should really work in parallel.


-- v --

v@iki.fi
