Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWIZVZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWIZVZW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWIZVZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:25:22 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:28880 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964808AbWIZVZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:25:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cs1J/SQQeK323V/iZFIac693p5Jx5lfWcgC+VX3uTYHSBJ/v4etzSD3Olc4JS5PDZS2jQ2aXIVEalMmXJlzwXIOjA89MC5PVgbpQadvOUZvJnsoBStNsRBzO3uRRwdx9BMk1+ydYoYJvJOPtHEEIi7E/qDzF8G7+d0WBoJXOXbI=
Message-ID: <4d8e3fd30609261425ob262489nec1240f5a0c5050f@mail.gmail.com>
Date: Tue, 26 Sep 2006 23:25:19 +0200
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: x86/x86-64 merge for 2.6.19
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0609261339050.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609261244.43863.ak@suse.de> <200609262202.28846.ak@suse.de>
	 <Pine.LNX.4.64.0609261318240.3952@g5.osdl.org>
	 <200609262226.09418.ak@suse.de>
	 <Pine.LNX.4.64.0609261339050.3952@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Tue, 26 Sep 2006, Andi Kleen wrote:
> >
> > Yes that is why I did it. I still use quilt for my tree because it works
> > best for me, but together with all the i386 stuff I was over 230 patches
> > and email clearly didn't scale well to that much.
>
> Right. I'm actually surprised not more peole use git that way. It was
> literally one of the _design_goals_ of git to have people use quilt a a
> more "willy-nilly" front-end process, with git giving the true distributed
> nature that you can't get from that kind of softer patch-queue like
> system.
>
> We discussed some quilt integration stuff, but nobody actually ended up
> ever using both (except indirectly, as with the whole Andrew->Linus
> stage). StGit kind of comes closest.
>
> So I don't think your usage should be considered to be even strange. I
> think it makes sense. I just think that everybody agrees that if we can do
> it in chunks of a few tens of patches most of the time instead of chunks
> of 225, everybody will have an easier time, if only because the latency
> goes down, and it's just easier to react.
>
> That said, the merges with Andrew are also sometimes in the 150+ patch
> range, and merging with other git trees can sometimes bring in even more.

Linus,
out of curiosity, wouldn't be better to sync with Andrew via git?
Why via plain patches?

What am I missing?

Thanks.

-- 
Paolo
http://paolo.ciarrocchi.googlepages.com
http://picasaweb.google.com/paolo.ciarrocchi
