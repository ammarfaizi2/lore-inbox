Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317159AbSFKQZG>; Tue, 11 Jun 2002 12:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317161AbSFKQZF>; Tue, 11 Jun 2002 12:25:05 -0400
Received: from dsl-213-023-038-217.arcor-ip.net ([213.23.38.217]:48001 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317159AbSFKQZE>;
	Tue, 11 Jun 2002 12:25:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: 2.5.21: kbuild changes broke filenames with commas
Date: Tue, 11 Jun 2002 18:22:37 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Russell King <rmk@arm.linux.org.uk>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0206111213001.12427-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17HoPl-0000AK-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 June 2002 18:14, Alexander Viro wrote:
> On Tue, 11 Jun 2002, Daniel Phillips wrote:
> 
> > > Is it really worth adding complexity to a build system to work around
> > > what is really a GCC bug for just one file?  I don't think so.
> > 
> > Are you sure that complexity was added just to handle commas in names?
> > Or is it really an example of how good design never gave this bug a
> > chance to exist in the first palce.
> > 
> > I *really* don't like the idea of papering over such bugs by curing the
> > symptoms, as you seem to be advocating.
> 
> AFAICS you are advocating exactly that - papering over the idiotic
> gcc options syntax by kludges in build system...

So you want to leave this hole sitting there waiting for someone else
to step in it, until gcc gets fixed?  I'd think a bug report would be
a more effective solution than holding one's breath until blue in the
face.

I don't have a problem with fixing this at the interface to gcc level,
as then it's fixed definitively for the whole kbuild system.  I do have
a problem with just changing the names of files that trigger the bug,
that's sloppy beyond the belief and it's the stuff that substandard
systems are made of.

-- 
Daniel
