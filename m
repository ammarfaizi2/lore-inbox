Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261972AbTCZUv7>; Wed, 26 Mar 2003 15:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262482AbTCZUv7>; Wed, 26 Mar 2003 15:51:59 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:54457 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S261972AbTCZUv6>; Wed, 26 Mar 2003 15:51:58 -0500
Date: Wed, 26 Mar 2003 22:02:54 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Pavel Machek <pavel@ucw.cz>,
       James Bourne <jbourne@hardrock.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030326210254.GA31744@wohnheim.fh-wedel.de>
References: <3E7E4C63.908@gmx.de> <Pine.LNX.4.44.0303231717390.19670-100000@cafe.hardrock.org> <20030324003946.GA11081@wohnheim.fh-wedel.de> <3E7E736D.4020200@zytor.com> <20030324144219.GC29637@suse.de> <20030327074727.GA3021@zaurus.ucw.cz> <20030326203042.GA31359@suse.de> <3E82107F.1060204@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E82107F.1060204@zytor.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 March 2003 12:41:35 -0800, H. Peter Anvin wrote:
> >  > 
> >  > That looks like ugly can of worms to me.
> >  > "what kernel do you have?"
> >  > "2.4.25 and it did two downloads; I was
> >  > compiling it on the friday night"

It look like a good thing to me, iff done right. iff.

> > So make one of the patches change extra-version to -errataN or the like.

And the script doing the automatic downloads should refuse to apply
any patch that doesn't change extra-version. When something like this
happens to -ac2, people download it manually and know, it is in fact
-ac3. But here...

> Basically what we're talking about now is someone to maintain an "errata
> tree" -- someone to maintain sub-point releases (2.4.25.1, .2, etc.) and
> to decide what those are.
> 
> The other option would be to have it called something like
> 2.4.25-ep36-ep42-ep96 if errata patches 36, 42 and 96 were applied.
> 
> I think sub-point releases are better, since it at least cuts down the
> number of possible combinations.

I agree. There should be no point in finer granularity than sub-point
releases.  Even those should be kept as small as possible, completely
empty if possible.

Jörn

-- 
Homo Sapiens is a goal, not a description.
-- unknown
