Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262882AbTC0FJs>; Thu, 27 Mar 2003 00:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262886AbTC0FJs>; Thu, 27 Mar 2003 00:09:48 -0500
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:19857 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP
	id <S262882AbTC0FJr>; Thu, 27 Mar 2003 00:09:47 -0500
Date: Wed, 26 Mar 2003 22:20:54 -0700 (MST)
From: James Bourne <jbourne@hardrock.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Dave Jones <davej@codemonkey.org.uk>, Pavel Machek <pavel@ucw.cz>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Ptrace hole / Linux 2.2.25
In-Reply-To: <3E82107F.1060204@zytor.com>
Message-ID: <Pine.LNX.4.44.0303262211360.14154-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Mar 2003, H. Peter Anvin wrote:

> Dave Jones wrote:
> > On Thu, Mar 27, 2003 at 08:47:27AM +0100, Pavel Machek wrote:
> > 
> >  > > and have it wget patches from k.o, verify signatures and auto-apply them,
> >  > > which removes the "admin didnt even know there were patches
> >  > > that needed to be applied" possibility.
> >  > 
> >  > That looks like ugly can of worms to me.
> >  > "what kernel do you have?"
> >  > "2.4.25 and it did two downloads; I was
> >  > compiling it on the friday night"
> > 
> > So make one of the patches change extra-version to -errataN or the like.
> > 
> 
> Basically what we're talking about now is someone to maintain an "errata
> tree" -- someone to maintain sub-point releases (2.4.25.1, .2, etc.) and
> to decide what those are.

I agree with this format vs. the ep* format as it would be far easier to
find the latest cumulative errata patch...  Wouldn't the sub-point release
be a part of the errata patch?  I think it might get out of hand if there
are too many different bits to deal with, the errata tree and sub-point
release being seperate I mean..  IE if someone grabs the errata patches they
should then be running the most secure and stable version of the current
kernel available...  This also prevents having multiple trees around that
require sync, as there would be no errata patches required for a kernel with
no urgent patch releases (either bugfix or security related).  2.4.25 would
basically be 2.4.25.0 and until someone finds a show stopping problem there
wouldn't be the need for any additional patches...

Regards
James Bourne


> 
> The other option would be to have it called something like
> 2.4.25-ep36-ep42-ep96 if errata patches 36, 42 and 96 were applied.
> 
> I think sub-point releases are better, since it at least cuts down the
> number of possible combinations.
> 
> 	-hpa
> 
> 

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  

