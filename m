Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284251AbRLFUhx>; Thu, 6 Dec 2001 15:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285188AbRLFUhq>; Thu, 6 Dec 2001 15:37:46 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:61957 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S284248AbRLFUg5>; Thu, 6 Dec 2001 15:36:57 -0500
Date: Thu, 6 Dec 2001 14:12:33 +0000
From: Pavel Machek <pavel@suse.cz>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endianness-aware mkcramfs
Message-ID: <20011206141232.B122@toy.ucw.cz>
In-Reply-To: <3C0BD8FD.F9F94BE0@mvista.com> <3C0CB59B.EEA251AB@lightning.ch> <9uj5fbfm@cesium.transmeta.com> <20011205013630.C717@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011205013630.C717@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Wed, Dec 05, 2001 at 01:36:30AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > As told above, it could be cleaner, but I don't know of a nice method of
> > > accessing byteorder dependent data through structures.
> > 
> > This isn't the right way to deal with this.  The right way to deal
> > with this is to get all systems to read cramfs the same way.
> 
> Yes, from a CS point of view. 
> 
> But practically cramfs is created once to contain some kind of
> ROM for embedded devices. So if we never modify these data again,
> why not creating it in the required byte order? 

Because you want to be able to mount cramfs from your devel machine.

Or imagine putting cramfs on a CD.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

