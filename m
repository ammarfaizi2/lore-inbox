Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263280AbSLJR7w>; Tue, 10 Dec 2002 12:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbSLJR7w>; Tue, 10 Dec 2002 12:59:52 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:45322 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S263280AbSLJR7w>; Tue, 10 Dec 2002 12:59:52 -0500
Subject: Re: [BUG]: agpgart for i810 chipsets broken in 2.5.51
From: Antonino Daplas <adaplas@pol.net>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021210161725.GA577@codemonkey.org.uk>
References: <1039522886.1041.17.camel@localhost.localdomain>
	<20021210131143.GA26361@suse.de>
	<1039538881.2025.2.camel@localhost.localdomain>
	<20021210144852.GD26361@suse.de>
	<1039547205.1086.25.camel@localhost.localdomain> 
	<20021210161725.GA577@codemonkey.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1039553988.1055.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 02:01:25 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 21:17, Dave Jones wrote:
> On Wed, Dec 11, 2002 at 12:07:45AM +0500, Antonino Daplas wrote:
>  > > That chunk of X code is crap. So much so, that someone even put a
>  > > comment there (not that what they suggested was much better).
>  > > 
>  > > See line 122 of http://www.atomised.org/docs/XFree86-4.2.1/agp_8c-source.html
>  > > 
>  > Ouch.  That's a sh??ty version check.  And it has to be present from
>  > 4.0.0 to 4.2.1, and if they don't correct it, 4.3.0.
> 
> Andreas Schwab pointed out to me, that due to the broken boolean check,
> I can bump the version to 0.100 and it'll work. At least until the
> X folks change/remove that code.

I've tested using version 0.100 and it works just fine.

Tony


