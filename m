Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314747AbSDVUxi>; Mon, 22 Apr 2002 16:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314745AbSDVUxh>; Mon, 22 Apr 2002 16:53:37 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:54269 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S314747AbSDVUx2>; Mon, 22 Apr 2002 16:53:28 -0400
Date: Mon, 22 Apr 2002 16:53:27 -0400
From: Doug Ledford <dledford@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Larry McVoy <lm@bitmover.com>, Ian Molton <spyro@armlinux.org>,
        linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-ID: <20020422165327.A914@redhat.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Larry McVoy <lm@bitmover.com>, Ian Molton <spyro@armlinux.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204202108410.10137-100000@home.transmeta.com> <E16zLEf-0001I7-00@starship> <20020422155357.B877@redhat.com> <E16zNxY-0001Ld-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 10:29:19PM +0200, Daniel Phillips wrote:
> On Monday 22 April 2002 21:53, Doug Ledford wrote:
> > On Sun, Apr 21, 2002 at 07:34:49PM +0200, Daniel Phillips wrote:
> > > How about a URL instead?  Any objection?
> > 
> > Yes.  Why should I have to cut and paste (assuming I'm in X) or
> > write down
> 
> What???   What kind of system are you running?  Err... redhat supports
> cut and paste I thought. <-- funnny.

Depends on what you use to read the file containing the URL.  Obviously, 
if I'm Al Viro I'm on a text console and wouldn't use a mouse if you 
cemented it in my hand, so cut and paste isn't an option.

> > and transpose some URL from a file that used to contain
> > the exact instructions I need in order to get those instructions now
> 
> Bogus.  You'd have to do the same to edit/list the file.

No, I wouldn't.  In one case I would do "less <filename>" and in the other 
case I would do "less <filename>", ohh damn, it's only a pointer to the 
real docs, switch to X or install lynx on my system, go to URL.  It's a 
matter of having the appropriate documentation at hand vs. having to 
retrieve it.

> > I made a few docs that attempted to answer these questions and put them on 
>                                                                  ^^^^^^^^^^^
> > my web site along side the patches themselves.  These docs most generally 
>   ^^^^^^^^^^^
> Thanks for your story.  It's exactly what I've suggested, put the BK docs
> on a web site.

I put my docs on my web site because that's what I owned/controlled and it 
was relevant to people already coming to my web site.  That in no way 
indicates that your position is correct, especially since you ignored to 
truly relevant item in my email:

> > information so that the whole picture, from start to finish, was all 
> > described in one easy to access place.

One place for relevant information, from start to finish.

> >  So, as a result, even though I 
> > could have pointed the reader to the patch man page, I didn't bother to 
> > make them read a large document full of options and possible means of 
> > screwing things up when all I really wanted them to know was "All of my 
> > patches are generated so that if you go into the top level of the linux 
> > source directory and type 'patch -p1 < patchname' then things will work 
> > properly".

Limited scope "How to use in this specific case" documentation.

Those were the relevant points you blithely skipped because you know they 
are true and hurt your position.  Selective response is something you've 
been practicing in this entire thread.

> You haven't read the thread closely, this was described before.  There are
> one documentation file and three scripts.  The documentation file is about
> half general description of Bitkeeper - which is quite unabashedly
> promotional and the author does describe it as an adverisement - and half
> how to use for submitting kernel patches.

Now, now Daniel, let's not put words into people's mouths.  Jeff has said 
he does like BitKeeper, and he said he could *see how you think his 
description is an advertisement* but that he *didn't write it as an 
advertisement*.

>  No matter, Bitkeeper is *all*
> nonfree and the issue is whether documentation for it should live in our
> kernel tree or on a web site.  I.e., should Linux be advertising Bitkeeper
> through the kernel source.

And I've already given you my answer.  If the documentation in question is
specific to how to perform my patch work in a BK environment specifically
so that I can interface with Linus' BK environment directly, then I don't
really care less what the BK license itself is, the document is *still* a
HOWTO submit a patch using BK document and belongs with the linux kernel
docs, not with BitKeeper's web site.

> E) What is the license?

That's relevant to the decision of whether or not I use BK.  It is not 
relevant to *how* I would use BK, should I choose to do so, in order to 
submit patches/interface with Linus.  Since the document in question is 
suppossed to be about how to use BK to interface with Linus, and not a 
general discussion of whether or not any given individual *should* use BK, 
this point is irrelevant in determining where the document should live.

> > Like I said, I haven't read the document.  But, if I did and it turned out 
> > that it was similar to my description of how to use patch to apply my 
> > aic7xxx patches, IOW if it truly was a limited scope "How to use BK to 
> > send patches to Linus" and provided just the needed BK information to 
> > teach the user the real goal, which is how to integrate their work into 
> > Linus' BK patch process, then I would be greatly offended should the 
> > document be moved out it's appropriate location in the linux kernel 
> > documentation directory to some web site where it doesn't really belong.  
> 
> Because you can't follow a url?  Give me a break.

No, because I detest censorship, and that's all that your spewing has 
amounted to so far.  Because from every description I've heard so far the 
document is a valid HOWTO about patch submission.  Because the various 
HOWTO documents about the linux kernel *belong* in the kernel 
documentation tree.  Because if we are going to change the proper location 
of kernel HOWTO documents then we need to do it on a universal basis, not 
by discriminating against BK because of it's license (which, again, is a 
"Should I use" not "How do I use" relevant issue only).

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
