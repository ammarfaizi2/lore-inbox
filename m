Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317154AbSFKQPA>; Tue, 11 Jun 2002 12:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317157AbSFKQO7>; Tue, 11 Jun 2002 12:14:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:46485 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317154AbSFKQO6>;
	Tue, 11 Jun 2002 12:14:58 -0400
Date: Tue, 11 Jun 2002 12:14:58 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Russell King <rmk@arm.linux.org.uk>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.21: kbuild changes broke filenames with commas
In-Reply-To: <E17HoBz-0000A0-00@starship>
Message-ID: <Pine.GSO.4.21.0206111213001.12427-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Jun 2002, Daniel Phillips wrote:

> > Is it really worth adding complexity to a build system to work around
> > what is really a GCC bug for just one file?  I don't think so.
> 
> Are you sure that complexity was added just to handle commas in names?
> Or is it really an example of how good design never gave this bug a
> chance to exist in the first palce.
> 
> I *really* don't like the idea of papering over such bugs by curing the
> symptoms, as you seem to be advocating.

AFAICS you are advocating exactly that - papering over the idiotic
gcc options syntax by kludges in build system...

