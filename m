Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281647AbRLDSfe>; Tue, 4 Dec 2001 13:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281533AbRLDSPg>; Tue, 4 Dec 2001 13:15:36 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:59304
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S283254AbRLDSOX>; Tue, 4 Dec 2001 13:14:23 -0500
Date: Tue, 4 Dec 2001 11:13:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: dalecki@evision.ag
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@caldera.de>,
        "Eric S. Raymond" <esr@thyrsus.com>, Keith Owens <kaos@ocs.com.au>,
        kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204181337.GL17651@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <E16BJ9v-0002ii-00@the-village.bc.nu> <3C0D077E.59C194B0@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C0D077E.59C194B0@evision-ventures.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 06:27:26PM +0100, Martin Dalecki wrote:
> Alan Cox wrote:
> > 
> > > Creating a dependency on Python? Is a non-issue. Current systems that
> > > are to run 2.5 or 2.6 are bloated beyond belief by glibc already, Python
> > > is nice and it does not create such unmaintainable mess. Whether
> > 
> > Python2 - which means most users dont have it.

Most users sure as hell shouldn't be playing with 2.5.x right now
anyways.  With any sort of 'luck' it'll be 6 months at least before
2.5.x becomes stable enough that it will probably compile all the time
again and not have a random fs eating bug.  In 6 months even woody might
be frozen :)

> And then you will end with:
> 
> python1.4x,
> python2,
> python3 rewrite in python1 and so on and so on.

Say what?  Python (with the exception of undocumented features) has been
pretty good about compatiblity.  If it works with 1.5.x and doesn't rely
on undocumented features, it'll work with 2.0x, 2.1x and 2.2x.

> Thanks but NO thanks

Then go help Greg Banks in his CML2-in-C project.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
