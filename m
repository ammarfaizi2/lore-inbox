Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312269AbSDUPo3>; Sun, 21 Apr 2002 11:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312344AbSDUPo2>; Sun, 21 Apr 2002 11:44:28 -0400
Received: from dsl-213-023-040-105.arcor-ip.net ([213.23.40.105]:50834 "EHLO
	starship") by vger.kernel.org with ESMTP id <S312269AbSDUPo1>;
	Sun, 21 Apr 2002 11:44:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rob Landley <landley@trommello.org>, Jeff Garzik <garzik@havoc.gtf.org>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Date: Sat, 20 Apr 2002 17:44:07 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <E16ygxR-0000cY-00@starship> <20020421080030.44E2647B@merlin.webofficenow.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16yx1z-0000jV-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's my wrapup...

On Sunday 21 April 2002 03:41, Rob Landley wrote:
> On Friday 19 April 2002 06:34 pm, Daniel Phillips wrote:
> > I'm not arguing that BK is not a good way to do the grunt maintainance
> > work. I think it is, and that's great.  Heck, I'm not arguing against
> > Bitkeeper *at all*.  I'm arguing against building the bitkeeper
> > documentation into the kernel tree, giving the impression that Bitkeeper is
> > *required* for submitting patches.
> 
> I'm under the impression that Linus specifically asked for that 
> documentation, because BK is a tool he used that he was getting flooded with 
> questions about.

Yes, it came out in the course of the thread - Linus and Jeff had a private
email exchange in which Linus add Jeff to push his Bitkeeper documentation
files into the tree.  Linus's tree, which is of course, 'our' tree as well,
in the sense that everybody here has code in it.

So... there are some who perceive the advent of Bitkeeper as a kind of
creeping takeover of the Linux development toolchain, and for these people,
seeing the documentation files appear in the Documentation directory as if
Bitkeeper were not only *a* sourcecode management tool, but *the* Linux
sourcecode management tool, is an irritant.  Any argument that these people
exist, or that they are irritated?

By the way, I'm not one of them, and I'm not going to do any further
speaking for them.  Just don't get the impression I'm kidding about this.

I have my own agenda: I'd like to see the development process carried out
more in the open and to that extent, increasing reliance on Bitkeeper,
with its convenient point-to-point push/pull paths is worrisome.

Interesting, Al Viro, the classic owner of a direct patch hotline to Linus,
continues to feed that pipeline with standard patches, which just goes to
show that Bitkeeper itself is not the problem.  And in fact it's not even
right to accuse Al of developing in secret, because if you go trolling
through his patch directory on kernel.org you'll get a good snapshot of
what he's working on, and of course, if you've got thick skin you can
always ask him.

Al's kind of a special case though.  What we have now is, *everybody* with
a piece of kernel to maintain is in on the private, point-to-point thing
now.  It's efficient, no doubt, but I fear we're also weakening one of one
the basic driving forces of Linux development, that is, the public debate
part.  If you go take a survey of current lkml postings you won't find a
lot of design discussion there, even though a huge amount of design work
is taking place at the moment, and many changes are taking place that will
affect kernel development for years to come.

It used to be that every major change would start with an [RFC].  Now the
typical way is to build private concensus between a few well-placed
individuals and go straight from there to feeding patches.  At least,
that's my impression of the trend.

This may in fact be nothing more than a fear.  However if there is any
chance I'm talking about a real phenomenon then I would indeed be remiss in
failing to draw attention to it.

If it's a real phenomenon then the question is, what if anything needs to
be done about it?  Well, I'm not going to suggest anything at the moment
because, in truth, I don't have concrete suggestions to make, I just have
a nagging feeling that now is the time to apply a bit of the old eternal
vigilance.

Besides, OLS is coming up fast, and there the price of a plane ticket buys
you the chance to be part of the cabal (oops, the cabal that doesn't
exist) for a week.  Erm, and if there are real issues, they are certain to
be raised.

All that said, I have to observe that the current process is *not broken*
in the sense that development is now proceeding at a truly impressive rate,
perhaps because of the success of kernel 2.4 in delivering true enterprise-
class functionality, thus removing the immediate pressure to perform.  And
so, a lot of work is being done on longstanding deficiencies that were
never stoppers, but more in the class of 'wouldn't it be nice if this
didn't suck as much as it does'.

> The question isn't really whether BitKeeper is required for kernel 
> development, it's a question of whether submitting patches to LINUS is 
> required for kernel development.
> 
> It seems like the BitKeeper documentation belongs together with the other 
> submitting patches documentation, and should be moved to the directory 
> "Documentation/Linus".

Well you know, that would be nice.  At least it would show a little
sensitivity to the issue.  Though arguably the prospect of Linus acting
sensitive could be more worrisome than anything ;-)

> I.E. explicitly, the Kernel is only interested in documenting bitkeeper to 
> the extent we're documenting how Linus works.  (And it IS how Linus works.)

> > > Even if your conclusion is correct (it might be), how do you use
> > > that to support the argument that, less discussion occurs due to BK?
> >
> > We haven't established that, we do see a strong correlation.  But think.
> > It's obvious anyway, why discuss anything in public when you don't have
> > to?  Just push it straight to Linus's tree, why bother with formalities?
> > It's so easy.
> 
> And this differs from emailing him a patch without cc'ing linux-kernel in 
> what way?

Depending on the nature of the patch, both are wrong.  It's just getting very
easy to mix fundamental changes in with the 'boring' patch stream.  IMHO, the
temptation to do this needs to be resisted.

> Either you trust Linus's judgment about what patches to accept, or you use 
> somebody else's tree.  Did I miss where voting on linux-kernel ever got a 
> patch in that Linus didn't want to merge, or kept one out that he did?

Not voting, discussion.  Without the discussion we miss the chance to get
thousands of eyeballs on the issue, some of which may be more experienced in
certain aspects of the work than the designer/submitted.

> And AFTER the merge, you still get to flame all you want.

No no no.  Think about what you just said.  Barn.  Door.  Horse.  Gone.

> The ONLY reduction in access I can see to Linus's pending unmerged patch 
> queue is due to the fact that completed patches don't hang around unmerged 
> for months at a time anymore.  And since Bitkeeper seems to have 
> significantly contributed to lubricating Linus's in-box, I consider it a net 
> benefit.

Yes, I haven't tried that yet myself but we shall see.  True, I haven't noticed
a lot of grumbling about dropped patches lately.  Replaced by other grumbling
I suppose.

> Proprietary software sucks when you derive work from it in an exclusive and 
> dependent way.  Then they own your derived work.  (Like a microsoft word file 
> you wrote, which microsoft can charge you to access because they own word and 
> your file is useless without it.)  When it's something you can use but don't 
> have to, it's basically a service.  Not owning a service is unsurprising.

Huh.  I think the advertising material that Bitkeeper has now got in the Linux
tree is excessive, given its license, and I don't have more to say about that.

-- 
Daniel
