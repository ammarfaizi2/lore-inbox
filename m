Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbSLKXIB>; Wed, 11 Dec 2002 18:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbSLKXIB>; Wed, 11 Dec 2002 18:08:01 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55567 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S266292AbSLKXIB>; Wed, 11 Dec 2002 18:08:01 -0500
Date: Thu, 12 Dec 2002 00:15:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jirka Kosina <jikos@jikos.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Kill TRUE/FALSE from hp100.c
Message-ID: <20021211231546.GB10700@atrey.karlin.mff.cuni.cz>
References: <20021210215612.GA514@elf.ucw.cz> <20021211224734.A7023@infradead.org> <Pine.LNX.4.50.0212120003480.5642-100000@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0212120003480.5642-100000@twin.jikos.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Kernel coding style does not like TRUE/FALSE, AFAICS. Please apply,
> > What's even more interesting:  were did the defintions of TRUE/FALSE
> > as used by hp100.c come from?
> 
> AFAIK drivers/net/hp100.h
> 
> Should probably be also removed.
> 
> Quick grepping in drviers/ showed many places, where TRUE/FALSE semantics
> is also used...probably should be removed too, shouldn't it?

Yes... I killed these because they hurt my eyes; I don't have to deal
with others so I'm unlike to go and kill them.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
