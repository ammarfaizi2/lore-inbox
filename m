Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261648AbTCPXP3>; Sun, 16 Mar 2003 18:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261653AbTCPXP2>; Sun, 16 Mar 2003 18:15:28 -0500
Received: from msp-24-163-212-250.mn.rr.com ([24.163.212.250]:152 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261648AbTCPXP1>; Sun, 16 Mar 2003 18:15:27 -0500
Subject: Re: constant Bitkeeper bitching
From: Shawn <core@enodev.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030316224643.GB1252@dualathlon.random>
References: <1047837820.3966.8.camel@localhost.localdomain>
	 <20030316224643.GB1252@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047857178.30848.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 16 Mar 2003 17:26:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for being a sane voice, btw...

On Sun, 2003-03-16 at 16:46, Andrea Arcangeli wrote:
> On Sun, Mar 16, 2003 at 12:03:40PM -0600, Shawn wrote:
> > [..] You had
> > patches, folks... [..]
> I agree with the rest but note that the above argument is silly too.
> Patches are missing a great deal of info. bitkeeper is more useful for a
> reason. Until today we had an information-loss problem, that was fixed
> only for a restricted number of people for the last year, so it was very
> far from a solution from my point of view. Today thanks to the kernel
> CVS that Larry thankfully provided, IMHO this is finally solved and I
> greatly appreciate that.

I don't disagree with you, it's just that this most recent thread was
mainly about how the CVS gateway is/was lacking. (unless I'm missing the
whole point). I would challenge any corporation to do what Larry has
done, and tackle SCM to the best of his charitable ability for linux
kernel development. Having said that, I'll say that of course concerns
of the past had validity to them. So, if I'm not mistaken, I think we're
agreeing.

> Of course if you don't develop the kernel you can live fine with
> monolithic undocumented patches, you're not going to audit those diffs
> anyways, do you? Few people will appreciate the difference between
> patches and bk, but for developers having the finer granularity helps a
> lot, so saying "go back to patches" is a no-way.  Just try to extract
> stuff from the -ac tree and you get the idea, I'm stunned how can Alan
> submit stuff to Marcelo and Linus w/o major pain and leftovers (ok, some
> are driver changes and they're easy to extract, but not everything is
> that simple and self contained).

Ditto on -ac... Actually, all you hard hitters kindof amaze me. I
appreciate all y'all. And of course, I'm not saying go back to patches.
It's just that when bk was offered as a solution, strings attached or
no, it added a lot of sanity to the way changes are introduced into the
kernel, and thankfully historical comments and whatever other metadata.
Before that there was only lkml.

I'll try to clarify the point I was trying to make... Some all-too-vocal
folks, even after the bk -> cvs gateway was created were saying "not
good enough" because it was "lossy". It is the fact that bk -> cvs
couldn't possibly lose any more than was lost inherently by not using
bk. in other syntax...
	lossiness("BK-to-CVS gw") == BK - "diff/patch"

Basically, it's Linus's tree. He can get /all/ the meta-data out at will
and convert it if he pleases, regardless of the discussions going on
here. In any case, Larry is busy coding up "BitchKeeper" so threads like
this can be managed more efficiently ;P


