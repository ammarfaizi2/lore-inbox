Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129182AbRBAGwy>; Thu, 1 Feb 2001 01:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129714AbRBAGwd>; Thu, 1 Feb 2001 01:52:33 -0500
Received: from ARGENTIUM.MIT.EDU ([18.241.0.107]:36614 "EHLO argentium.mit.edu")
	by vger.kernel.org with ESMTP id <S129142AbRBAGwa>;
	Thu, 1 Feb 2001 01:52:30 -0500
Message-ID: <3A7907A9.4D501C22@mit.edu>
Date: Thu, 01 Feb 2001 01:52:25 -0500
From: Matt Yourst <yourst@mit.edu>
Organization: Massachusetts Institute of Technology
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-mtyrel-i686pII i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Compiling 2.4.1: undefined reference to `__buggy_fxsr_alignment'
In-Reply-To: <3A788DDE.AF82E72F@mit.edu> <3A789A81.78A59680@Home.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I used regular gcc 2.95.2 and it compiled and linked without problems.
Thanks.

Shawn Starr wrote:
> 
> pgcc borks 2.4.1 kernel and prereleases (sadly I found this out the same
> way).
> 
> Shawn.
> Matt Yourst wrote:
> 
> > Hi,
> >
> > I just tried to compile 2.4.1 and I'm getting the error "undefined
> > reference to `__buggy_fxsr_alignment'" when trying to do the final
> > link. It looks like this check was something 2.4.1 added to
> > include/asm-i386/bugs.h to fail the kernel build if part of the thread
> > structure wasn't aligned on a 16-byte boundary (which seems to make
> > sense given FXSR's alignment requirements.) When was this check added?
> > I assumed it was a bug in 2.4.0 that was just recently discovered, but
> > I didn't see anything in the ChangeLog to that effect.
>...

-------------------------------------------------------------
 Matt T. Yourst        Massachusetts Institute of Technology
 yourst@mit.edu                                 617.225.7690
 513 French House - 476 Memorial Drive - Cambridge, MA 02139
-------------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
