Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262795AbSKDVDQ>; Mon, 4 Nov 2002 16:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262804AbSKDVDQ>; Mon, 4 Nov 2002 16:03:16 -0500
Received: from pc132.utati.net ([216.143.22.132]:63360 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S262795AbSKDVDP> convert rfc822-to-8bit; Mon, 4 Nov 2002 16:03:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: CONFIG_TINY
Date: Mon, 4 Nov 2002 16:09:48 +0000
User-Agent: KMail/1.4.3
Cc: Bill Davidsen <davidsen@tmr.com>, Adrian Bunk <bunk@fs.tum.de>,
       Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
References: <20021031011002.GB28191@opus.bloom.county> <200211012059.32304.landley@trommello.org> <20021104195144.GC27298@opus.bloom.county>
In-Reply-To: <20021104195144.GC27298@opus.bloom.county>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211041609.48587.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 November 2002 19:51, Tom Rini wrote:
> On Mon, Nov 04, 2002 at 02:13:48AM +0000, Rob Landley wrote:

> > I've used -Os.  I've compiled dozens and dozens of packages with -Os.  It
> > has always saved at least a few bytes, I have yet to see it make
> > something larger.  And in the benchmarks I've done, the smaller code
> > actually runs slightly faster.  More of it fits in cache, you know.
>
> Then we don't we always use -Os?

I normally do, actually.  Works For Me (tm).  Dunno about all possible 
architectures or all kernel versions, but then compiling WITHOUT -O2 
apparently produces an unusable kernel due to some missing needed inlines, 
so...

There's also a drive to "inline less stuff" underway, which I consider vaguely 
related...

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
