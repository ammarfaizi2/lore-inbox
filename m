Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264408AbTDXEd0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264413AbTDXEd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:33:26 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:51387 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S264408AbTDXEdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:33:23 -0400
Date: Wed, 23 Apr 2003 21:40:50 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
In-Reply-To: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0304232121340.21091-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not philosophically opposed to DRM systems. What I am concerned with
is being made a prisoner by my applications. So, if the kernel I run has
to be signed by the someone my proprietary application vendor trusts, so
that I can view a piece of data provided by a third party, that limits the 
freedom I have to choose what I put in my kernel. In some circumstances I 
might be willing to forgo that freedom, but as a general rule I see it as 
an unfortunate instrustion. 

Signatures for the purposes of establishing the identity of authors, and 
the intactness or binary or sources packages. are a seperate issue, 
I support that entirely...

joelja

On Wed, 23 Apr 2003, Linus 
Torvalds wrote:

> 
> Ok, 
>  there's no way to do this gracefully, so I won't even try. I'm going to 
> just hunker down for some really impressive extended flaming, and my 
> asbestos underwear is firmly in place, and extremely uncomfortable.
> 
>   I want to make it clear that DRM is perfectly ok with Linux!
> 
> There, I've said it. I'm out of the closet. So bring it on...
> 
> I've had some private discussions with various people about this already,
> and I do realize that a lot of people want to use the kernel in some way
> to just make DRM go away, at least as far as Linux is concerned. Either by
> some policy decision or by extending the GPL to just not allow it.
> 
> In some ways the discussion was very similar to some of the software
> patent related GPL-NG discussions from a year or so ago: "we don't like
> it, and we should change the license to make it not work somehow". 
> 
> And like the software patent issue, I also don't necessarily like DRM
> myself, but I still ended up feeling the same: I'm an "Oppenheimer", and I
> refuse to play politics with Linux, and I think you can use Linux for
> whatever you want to - which very much includes things I don't necessarily
> personally approve of.
> 
> The GPL requires you to give out sources to the kernel, but it doesn't
> limit what you can _do_ with the kernel. On the whole, this is just
> another example of why rms calls me "just an engineer" and thinks I have
> no ideals.
> 
> [ Personally, I see it as a virtue - trying to make the world a slightly
>   better place _without_ trying to impose your moral values on other 
>   people. You do whatever the h*ll rings your bell, I'm just an engineer 
>   who wants to make the best OS possible. ]
> 
> In short, it's perfectly ok to sign a kernel image - I do it myself
> indirectly every day through the kernel.org, as kernel.org will sign the
> tar-balls I upload to make sure people can at least verify that they came
> that way. Doing the same thing on the binary is no different: signing a
> binary is a perfectly fine way to show the world that you're the one
> behind it, and that _you_ trust it.
> 
> And since I can imaging signing binaries myself, I don't feel that I can
> disallow anybody else doing so.
> 
> Another part of the DRM discussion is the fact that signing is only the 
> first step: _acting_ on the fact whether a binary is signed or not (by 
> refusing to load it, for example, or by refusing to give it a secret key) 
> is required too.
> 
> But since the signature is pointless unless you _use_ it for something,
> and since the decision how to use the signature is clearly outside of the
> scope of the kernel itself (and thus not a "derived work" or anything like
> that), I have to convince myself that not only is it clearly ok to act on
> the knowledge of whather the kernel is signed or not, it's also outside of
> the scope of what the GPL talks about, and thus irrelevant to the license.
> 
> That's the short and sweet of it. I wanted to bring this out in the open, 
> because I know there are people who think that signed binaries are an act 
> of "subversion" (or "perversion") of the GPL, and I wanted to make sure 
> that people don't live under mis-apprehension that it can't be done.
> 
> I think there are many quite valid reasons to sign (and verify) your
> kernel images, and while some of the uses of signing are odious, I don't
> see any sane way to distinguish between "good" signers and "bad" signers.
> 
> Comments? I'd love to get some real discussion about this, but in the end 
> I'm personally convinced that we have to allow it.
> 
> Btw, one thing that is clearly _not_ allowed by the GPL is hiding private
> keys in the binary. You can sign the binary that is a result of the build
> process, but you can _not_ make a binary that is aware of certain keys
> without making those keys public - because those keys will obviously have
> been part of the kernel build itself.
> 
> So don't get these two things confused - one is an external key that is
> applied _to_ the kernel (ok, and outside the license), and the other one
> is embedding a key _into_ the kernel (still ok, but the GPL requires that
> such a key has to be made available as "source" to the kernel).
> 
> 			Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"



