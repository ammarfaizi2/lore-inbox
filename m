Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130766AbRBCDkk>; Fri, 2 Feb 2001 22:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130834AbRBCDkb>; Fri, 2 Feb 2001 22:40:31 -0500
Received: from kullstam.ne.mediaone.net ([66.30.138.210]:49800 "HELO
	kullstam.ne.mediaone.net") by vger.kernel.org with SMTP
	id <S130766AbRBCDkQ>; Fri, 2 Feb 2001 22:40:16 -0500
From: "Johan Kullstam" <kullstam@ne.mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS Oops (2.4.1, deterministic, symlink related)
In-Reply-To: <Pine.LNX.4.30.0102021438320.9097-100000@age.cs.columbia.edu>
Organization: none
Date: 02 Feb 2001 22:43:42 -0500
In-Reply-To: <Pine.LNX.4.30.0102021438320.9097-100000@age.cs.columbia.edu>
Message-ID: <m2hf2ce8i9.fsf@euler.axel.nom>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu <ionut@cs.columbia.edu> writes:

> On Fri, 2 Feb 2001, Alan Cox wrote:
> 
> > Oh I can see why Hans wants to cut down his bug reporting load. I can also
> > say from experience it wont work. If you put #error in then everyone will
> > mail him and complain it doesnt build, if you put #warning in nobody will
> > read it and if you dont put anything in you get the odd bug report anyway.
> >
> > Basically you can't win and unfortunately a shrink wrap forcing the user
> > to read the README file for the kernel violates the GPL ..
> 
> Oh, don't get me wrong, I fully understand that it's a lose-lose
> situation. All I'm saying is that it was an incredibly bad idea to have
> two compilers, one broken and one ok, identify themselves as the same
> version.

unfortunately, it's not limited to redhat and it's not limited to
redhat's gcc-2.96.  gcc-2.95.2 has some bugs (a certain strength
reduction bug comes to mind).  no new official gcc has come for over a
year.  many distributions have applied a patch to fix the strength
reduction bug.  do they all alter their version number?  of those that
do, do they alter it consistently?

-- 
J o h a n  K u l l s t a m
[kullstam@ne.mediaone.net]
Don't Fear the Penguin!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
